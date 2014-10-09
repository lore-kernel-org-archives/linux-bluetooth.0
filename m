Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141009141430.GA31807@t440s.P-661HNU-F1>
References: <1412859828-6224-1-git-send-email-fons@spotify.com> <20141009141430.GA31807@t440s.P-661HNU-F1>
From: Alfonso Acosta <fons@spotify.com>
Date: Thu, 9 Oct 2014 16:39:18 +0200
Message-ID: <CAHF=Y4pJOC3gA1g-+o1e4HRJraFqpCGOAUuqNiS7b0CvAqEBJg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Defer connection-parameter removal when
 unpairing without disconnecting
To: Alfonso Acosta <fons@spotify.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> +
>> +     if (test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags))
>> +             hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
>>  }
>>
>>  /* Enter sniff mode */
>> @@ -544,6 +547,9 @@ int hci_conn_del(struct hci_conn *conn)
>>
>>       hci_conn_del_sysfs(conn);
>>
>> +     if (test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags))
>> +             hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
> I suppose the above two test_and_clear_bit() calls should be operating
> on HCI_CONN_PARAM_REMOVAL_PEND and not HCI_CONN_MODE_CHANGE_PEND?

Darn. Yes, my bad.


>> @@ -2700,6 +2700,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>>       struct hci_cp_disconnect dc;
>>       struct pending_cmd *cmd;
>>       struct hci_conn *conn;
>> +     struct hci_conn *le_conn = NULL;
>
> I don't think you need to initialize this here since it's
> unconditionally set in the first LE addr type branch and only touched
> again in the second LE branch. Actually do you even need this second
> variable if you simply assign to conn when you look up the LE
> connection?

I did it to silence an unitialized-variable warning from gcc  (at least
the 4.8 version I am using is not good enough to conclude that the
variable is initialized).

>> @@ -2752,8 +2763,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>>                       conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>>                                                      &cp->addr.bdaddr);
>>               else
>> -                     conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
>> -                                                    &cp->addr.bdaddr);
>> +                     conn = le_conn;
>
> Here you could then simply remove the "else" branch with a comment that
> the conn is already looked up for LE addresses earlier in the function.
> Not sure if that makes the code harder to follow though...

My intention was precisely to make it easier to follow by showing that
LE was being taken care of with an explicit assignment.

Buy yeah, I can simply remove le_conn altogether and add a comment instead.

Note that removing the else branch will also cause an
uninitialized-variable compiler warning on conn.

I could use uninitialized_var() instead of using NULL, I simply
decided against it after reading http://lwn.net/Articles/529954/

-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
