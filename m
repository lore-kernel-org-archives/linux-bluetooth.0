Return-Path: <cyrus@holtmann.org>
Message-ID: <35c90d960810060918l5887aedya50893238ca3aee7@mail.gmail.com>
Date: Mon, 6 Oct 2008 18:18:54 +0200
From: "Nick Pelly" <npelly@google.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: Keeping ACL link around after DBUS CreateBonding()
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1223016985.11272.38.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <35c90d960810021747j56d5bc2ie62c10ade0026694@mail.gmail.com>
	 <1223015762.11272.30.camel@violet.holtmann.net>
	 <35c90d960810022342p1fca607x4be774ae9e675fd9@mail.gmail.com>
	 <1223016985.11272.38.camel@violet.holtmann.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Oct 3, 2008 at 8:56 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> >> I have memories of one of you talking about a custom change to bluez
>> >> to not immediately drop the ACL link once DBUS CreateBonding() has
>> >> finished (so that SDP can then be done on that link).
>> >>
>> >> Do you know the patch to do this? I am currently experimenting with
>> >> changing the timer expiry in hci_conn_put() for disc_timer. Maybe
>> >> there's a nicer way.
>> >
>> > do you have a trace in BTSnoop format for me. We are using L2CAP raw
>> > sockets for bonding and thus the default 2 seconds disconnect timeout
>> > applies. Enough time to get SDP started on the same link. If the remote
>> > side however decides to disconnect us, we are out of luck.
>>
>> For this situation the ACL connection is not complete, so the 10ms
>> timeout applies. I have a patch to use the 2 second timeout code path
>> for both connecting and connected. I wonder if this would be useful in
>> mainline, or if this is just a strange behavior of our BRF6300 (it
>> completes pin code and link key before the ACL link is reported as
>> connected). I'll send you some logs tomorrow if that would still help.
>
> that is not strange behavior. That is just a device in security mode 3.
> The important question is who disconnects the link.

We (bluez kernel stack) disconnect the link due to the 10 ms timeout
that applies when the ACL link is in CONNECT. Here is a patch to use
the 2 second time out during CONNECT phase as well as CONNECTED. Does
this patch seem reasonable? It looks like just CONNECT || CONNECTED is
sufficient, but there are other modes like CONNECT2.

commit 0876dd6c7c3c5827c21bb0804453a249de234953
Author: Nick Pelly <npelly@google.com>
Date:   Fri Oct 3 16:07:50 2008 -0700

    bluetooth: Drop ACL link after 2 seconds not 10 ms when connecting.

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3446bc9..a2b0e09 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -341,7 +341,7 @@ static inline void hci_conn_put(struct hci_conn *conn)
                unsigned long timeo;
                if (conn->type == ACL_LINK) {
                        del_timer(&conn->idle_timer);
-                       if (conn->state == BT_CONNECTED) {
+                       if (conn->state == BT_CONNECTED || conn->state
== BT_CONNECT) {
                                timeo = msecs_to_jiffies(HCI_DISCONN_TIMEOUT);
                                if (!conn->out)
                                        timeo *= 2;



Nick
