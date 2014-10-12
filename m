Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5240CE7E-B366-410A-93C4-5FCC3358A68F@holtmann.org>
References: <1412991237-20847-1-git-send-email-fons@spotify.com>
 <F4236E26-CB50-4334-9AD9-0D930B2B9955@holtmann.org> <CAHF=Y4o7BE5hVzNgyXR0_jGPqNLnfjj1MgzuTU0iB-tvvgKa3A@mail.gmail.com>
 <5240CE7E-B366-410A-93C4-5FCC3358A68F@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
Date: Sun, 12 Oct 2014 02:16:45 +0200
Message-ID: <CAHF=Y4r+ofDDBv5+YpFPcvctqYAAGiwNj0u94+XDsoskbSF4Mw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Defer connection-parameter removal when unpairing
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


>>>> @@ -356,6 +356,9 @@ static void hci_conn_timeout(struct work_struct *w=
ork)
>>>>              conn->state =3D BT_CLOSED;
>>>>              break;
>>>>      }
>>>> +
>>>> +     if (test_and_clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags=
))
>>>> +             hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_ty=
pe);
>>>
>>> do we really need this one? The hci_conn_timeout should trigger when th=
e connection establishment has a timeout and that is really non of the conc=
erns here. And in case we hit an idle disconnect timeout, we are still endi=
ng up in hci_conn_del eventually, right? If not, I am having the slight fee=
ling that you might have uncovered a bug that we should fix.
>>
>> It's probably just lack of familiarity with the code, but it wasn't
>> all that clear to me that hci_conn_del is called after
>> hci_conn_timeout kicks in. I removed it.
>
> there is always a possibility that you found an actual bug that we trigge=
r, but has not done any harm. At least not harm that anybody has noticed so=
 far. So if this happens, then I like to fix the actual bug.

I have gone through the code again to revisit what made me think that
clearing the flag was necessary in hci_conn_timeout() and I may have
possibly found a couple of problems in the deallocation of connections
and handling of disconnection failures.

What made me think that the change in hci_conn_timeout() was necessary
were some call patterns like the following in hci_event.c:

hci_disconnect(conn, reason);
hci_conn_drop(conn);

I wrongly inferred from this that the connection clearing was
sometimes done in hci_conn_timeout() (hci_conn_drop() queues
hci_conn_timeout() when the reference count drops to zero) and not in
hci_conn_del(), to make sure that the connection was cleared
regardless of the status/completion events received from the
controller .

I see that, when receiving a Disconnect Complete event,
hci_disconn_complete_evt() deallocates the connection. But ...

1. What if the controller misbehaves and doesn't send a Disconnect
Complete event? AFAIU, the connection will never be deallocated in
this case.

Wouldn't it make sense to have a timer for this? e.g. make
hci_disconnect() queue hci_conn_timeout() and, in the later, delete
the connection if it's not referenced and it was already marked as
closed.

2. What if the controller sends an error in the Command Status event
and the Disconnect Complete never arrives?

I see that  hci_cs_disconnect() notifies userland if it was triggered
through mgmt, but it doesn't provide a retry mechanism in case the
disconnection came from the kernel itself. In fact, what happens with
the connection's deallocation in this case? Is it ensured in any way?

I apologize in advance if my analysis doesn't make much sense or makes
wrong assumptions, as you know, I am still a newbie :)







--=20
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
