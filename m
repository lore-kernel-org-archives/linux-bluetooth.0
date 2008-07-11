Return-Path: <cyrus@holtmann.org>
Message-ID: <bd5b16740807110143m3e1253bct2a5e270ab4b269dd@mail.gmail.com>
Date: Fri, 11 Jul 2008 11:43:30 +0300
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: "pramod gurav" <pramod_gurav_etc@yahoo.co.in>,
	"BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <693063.42845.qm@web8402.mail.in.yahoo.com>
MIME-Version: 1.0
References: <693063.42845.qm@web8402.mail.in.yahoo.com>
Cc: brflinux-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Add support for Texas Instruments' chips
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Pramod,

On Fri, Jul 11, 2008 at 9:12 AM, pramod gurav
<pramod_gurav_etc@yahoo.co.in> wrote:
> Hi Ohad
> Sorry to break the link.
> I am working on arm platform. I want to configure TI's brf6350 on UART.
> I read some of the mail on the list. I came to know that hci_ll.c provides
> support for brf6350.
> Is the hci lower level support in kernel enough to drive the chip?

Yes.

> What else I have to do at kernel side to bring UP my brf6350?

In general, if you are using 2.6.24 or higher, you don't need to do anything.
Otherwise, you will have to patch it with the HCILL patch.

That said, there are additional power management features we wrote for
the OMAP platform (e.g., the chip can wake up the host on Bluetooth
acitivity).
If you're interested in those patches, take a look at
http://brflinux.sourceforge.net/.

> Where would I get the brf script file for my chip?

That depends on the chip version and several decisions you should make.
We have a dedicated mailing list for that - please write to
brflinux-devel@lists.sourceforge.net for further assistance.

(you can subscribe to the list at
https://lists.sourceforge.net/lists/listinfo/brflinux-devel)

Best Regards,
Ohad.

>
> Your response is much awaited.
> Thanks and Best regards
>
> Pramod
>
> ----- Original Message ----
> From: Marcel Holtmann <marcel@holtmann.org>
> To: BlueZ development <bluez-devel@lists.sourceforge.net>
> Sent: Thursday, 10 July, 2008 6:03:23 PM
> Subject: Re: [Bluez-devel] [PATCH] Add support for Texas Instruments' chips
>
> Hi Ohad,
>
>> > please put all the TI code into hciattach_ti.c and then I gonna apply
>> > this patch.
>>
>> I'm gonna have to put some common definitions in hciattach.h then
>> (mainly struct uart_t).
>>
>> Is that ok ?
>
> no. Do the same as I did for hciattach_st.c
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
> Studies have shown that voting for your favorite open source project,
> along with a healthy diet, reduces your potential for chronic lameness
> and boredom. Vote Now at http://www.sourceforge.net/community/cca08
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
> ________________________________
> From Chandigarh to Chennai - find friends all over India. Click here.
> -------------------------------------------------------------------------
> Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
> Studies have shown that voting for your favorite open source project,
> along with a healthy diet, reduces your potential for chronic lameness
> and boredom. Vote Now at http://www.sourceforge.net/community/cca08
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
