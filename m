Return-Path: <cyrus@holtmann.org>
Message-ID: <35c90d960810061442r5edb776blbdf420ac067e9f9c@mail.gmail.com>
Date: Mon, 6 Oct 2008 23:42:48 +0200
From: "Nick Pelly" <npelly@google.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: Keeping ACL link around after DBUS CreateBonding()
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1223310384.11272.209.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_48079_26091607.1223329368785"
References: <35c90d960810021747j56d5bc2ie62c10ade0026694@mail.gmail.com>
	 <1223015762.11272.30.camel@violet.holtmann.net>
	 <35c90d960810022342p1fca607x4be774ae9e675fd9@mail.gmail.com>
	 <1223016985.11272.38.camel@violet.holtmann.net>
	 <35c90d960810060918l5887aedya50893238ca3aee7@mail.gmail.com>
	 <1223310384.11272.209.camel@violet.holtmann.net>
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_48079_26091607.1223329368785
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Oct 6, 2008 at 6:26 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> >> >> I have memories of one of you talking about a custom change to bluez
>> >> >> to not immediately drop the ACL link once DBUS CreateBonding() has
>> >> >> finished (so that SDP can then be done on that link).
>> >> >>
>> >> >> Do you know the patch to do this? I am currently experimenting with
>> >> >> changing the timer expiry in hci_conn_put() for disc_timer. Maybe
>> >> >> there's a nicer way.
>> >> >
>> >> > do you have a trace in BTSnoop format for me. We are using L2CAP raw
>> >> > sockets for bonding and thus the default 2 seconds disconnect timeout
>> >> > applies. Enough time to get SDP started on the same link. If the remote
>> >> > side however decides to disconnect us, we are out of luck.
>> >>
>> >> For this situation the ACL connection is not complete, so the 10ms
>> >> timeout applies. I have a patch to use the 2 second timeout code path
>> >> for both connecting and connected. I wonder if this would be useful in
>> >> mainline, or if this is just a strange behavior of our BRF6300 (it
>> >> completes pin code and link key before the ACL link is reported as
>> >> connected). I'll send you some logs tomorrow if that would still help.
>> >
>> > that is not strange behavior. That is just a device in security mode 3.
>> > The important question is who disconnects the link.
>>
>> We (bluez kernel stack) disconnect the link due to the 10 ms timeout
>> that applies when the ACL link is in CONNECT. Here is a patch to use
>> the 2 second time out during CONNECT phase as well as CONNECTED. Does
>> this patch seem reasonable? It looks like just CONNECT || CONNECTED is
>> sufficient, but there are other modes like CONNECT2.
>
> I really need to have a BTSnoop trace of this. I am not sure why you end
> up in a situation where the timer is active anyway. What kernel version
> are you running? Can you re-produce it with a 2.6.27-rc8 one?
>

Attached is the btsnoop from the CreateBonding()

Note the "Create Connection Cancel" right after completing bonding.
This is what this patch tries to address - allow 2 seconds before
disconnecting the ACL link instead of 10 ms for this scenario.

Also note that the "Create Connection Cancel" takes 40 seconds to
return from the BRF6300. To me this looks like a unrelated issue with
the TI chip (and I have a separate conversation going on with TI about
it).

This is from a 2.6.25 kernel. I dont have easy access to 2.6.27 to
test at the moment. I dont think any code has changed in this area.



> The CONNECT2 is the re-try case for concurrent connection attempts where
> link manager does not queue up the create connection.
>
> Regards
>
> Marcel
>
>
>

------=_Part_48079_26091607.1223329368785
Content-Type: application/octet-stream; name=dump.log
Content-Transfer-Encoding: base64
X-Attachment-Id: f_flzmp6cb0
Content-Disposition: attachment; filename=dump.log

YnRzbm9vcAAAAAABAAAD6gAAABEAAAARAAAAAgAAAAAA4TZPhAlLZwEFBA3F2mR/GQAYzAIAAAAB
AAAABwAAAAcAAAADAAAAAADhNk+ECbXbBA8EAAEFBAAAAAkAAAAJAAAAAwAAAAAA4TZPhA/pAgQX
BsXaZH8ZAAAAAAoAAAAKAAAAAgAAAAAA4TZPhA/w/wEMBAbF2mR/GQAAAAANAAAADQAAAAMAAAAA
AOE2T4QQBw0EDgoBDAQAxdpkfxkAAAAACQAAAAkAAAADAAAAAADhNk+EFElWBBYGxdpkfxkAAAAA
GwAAABsAAAACAAAAAADhNk+EURTyAQ0EF8XaZH8ZAAQwMDAwAAAAAAAAAAAAAAAAAAAADQAAAA0A
AAADAAAAAADhNk+EUT8lBA4KAQ0EAMXaZH8ZAAAAABoAAAAaAAAAAwAAAAAA4TZPhFRC6AQYF8Xa
ZH8ZAOPop3g4ddF3hR3J8O7rR00AAAAACgAAAAoAAAACAAAAAADhNk+EVG99AQgEBsXaZH8ZAAAA
AAoAAAAKAAAAAgAAAAAA4TZPhsOcogEIBAbF2mR/GQAAAAANAAAADQAAAAMAAAAAAOE2T4bDwP4E
DgoBCAQAxdpkfxkAAAAADQAAAA0AAAADAAAAAADhNk+Gw9XaBA4KAQgEAMXaZH8ZAAAAAA4AAAAO
AAAAAwAAAAAA4TZPhsPWFwQDCwIBAMXaZH8ZAAEB
------=_Part_48079_26091607.1223329368785--
