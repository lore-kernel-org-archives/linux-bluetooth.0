Return-Path: <cyrus@holtmann.org>
Message-ID: <5eee8c670804231250s471d74aei656686225a35e5f0@mail.gmail.com>
Date: Wed, 23 Apr 2008 20:50:22 +0100
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1208977443694@dmwebmail.dmwebmail.chezphil.org>
MIME-Version: 1.0
References: <5eee8c670804220813m351b6d10l57ad21bd34c812f0@mail.gmail.com>
	<1208977443694@dmwebmail.dmwebmail.chezphil.org>
Subject: Re: [Bluez-users] Apple wireless keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0666211883=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0666211883==
Content-Type: multipart/alternative;
	boundary="----=_Part_32761_1816179.1208980223167"

------=_Part_32761_1816179.1208980223167
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I was also getting "UP RUNNING PSCAN ISCAN", unlike the initial bug-reporter
but the 'hciconfig hci0 reset' command on reboot fixed the problem with my
Apple keyboard. Have you actually tried it?

Alex

On 23/04/2008, Phil Endecott <spam_from_bluez_users@chezphil.org> wrote:
>
> Odysseus Flappington wrote:
> > You're probably suffering from the following bug:
> >
> > https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394
> >
> > Try a 'hciconfig hci0 reset' after restarting and then your keyboard
> should
> > reconnect again.
>
>
> Thanks for the suggestion.  That bug reporter was seeing "UP RUNNING"
> but not scanning in the hciconfig output; I am getting "UP RUNNING
> PSCAN ISCAN", so I don't think it's the same thing.
>
> On more investigation, it seems that the failure happens after the
> keyboard has gone to sleep and I wake it up; I then see this in syslog:
>
> Apr 23 18:09:37 egypt hidd[2856]: New HID device 00:1E:52:F9:60:2C
> (Apple Inc. Keyboard)
> Apr 23 18:09:37 egypt kernel: input: Apple Inc. Keyboard as
> /class/input/input13
> Apr 23 18:09:37 egypt kernel: usb 3-2: uhci_result_common: failed with
> status 440000
> Apr 23 18:09:37 egypt kernel: usb 3-2: uhci_result_common: failed with
> status 440000
>
> Does anyone know what "status 440000" is?  It makes me think that it's
> a lower level problem with the USB dongle.
>
> After 30 mins I get this, which is presumably related:
> Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 ACL tx timeout
> Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 killing stalled ACL
> connection 2C:60:F9:52:1E:00
> Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 ACL tx timeout
> Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 killing stalled ACL
> connection 2C:60:F9:52:1E:00
>
> I can make the keyboard work again by re-plugging the USB dongle and
> waking up the keyboard.
>
> Anyway, I am going to try to get a USB bluetooth dongle that has a HID
> proxy mode, and hopefully this can all be avoided.  If anyone can
> suggest a particular brand/model that is known to work in HID proxy
> mode, please let me know!  Thanks.
>
>
>
> Phil.
>
>
>
>
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
> Don't miss this year's exciting event. There's still time to save $100.
> Use priority code J8TL2D2.
>
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_32761_1816179.1208980223167
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I was also getting &quot;UP RUNNING PSCAN ISCAN&quot;, unlike the initial bug-reporter but the &#39;hciconfig hci0 reset&#39; command on reboot fixed the problem with my Apple keyboard. Have you actually tried it?<br><br>Alex<br>
<br><div><span class="gmail_quote">On 23/04/2008, <b class="gmail_sendername">Phil Endecott</b> &lt;<a href="mailto:spam_from_bluez_users@chezphil.org">spam_from_bluez_users@chezphil.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Odysseus Flappington wrote:<br> &gt; You&#39;re probably suffering from the following bug:<br> &gt;<br> &gt; <a href="https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394">https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394</a><br>
 &gt;<br> &gt; Try a &#39;hciconfig hci0 reset&#39; after restarting and then your keyboard should<br> &gt; reconnect again.<br> <br> <br>Thanks for the suggestion.&nbsp;&nbsp;That bug reporter was seeing &quot;UP RUNNING&quot;<br>
 but not scanning in the hciconfig output; I am getting &quot;UP RUNNING<br> PSCAN ISCAN&quot;, so I don&#39;t think it&#39;s the same thing.<br> <br> On more investigation, it seems that the failure happens after the<br>
 keyboard has gone to sleep and I wake it up; I then see this in syslog:<br> <br> Apr 23 18:09:37 egypt hidd[2856]: New HID device 00:1E:52:F9:60:2C<br> (Apple Inc. Keyboard)<br> Apr 23 18:09:37 egypt kernel: input: Apple Inc. Keyboard as /class/input/input13<br>
 Apr 23 18:09:37 egypt kernel: usb 3-2: uhci_result_common: failed with<br> status 440000<br> Apr 23 18:09:37 egypt kernel: usb 3-2: uhci_result_common: failed with<br> status 440000<br> <br> Does anyone know what &quot;status 440000&quot; is?&nbsp;&nbsp;It makes me think that it&#39;s<br>
 a lower level problem with the USB dongle.<br> <br> After 30 mins I get this, which is presumably related:<br> Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 ACL tx timeout<br> Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 killing stalled ACL<br>
 connection 2C:60:F9:52:1E:00<br> Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 ACL tx timeout<br> Apr 23 18:39:37 egypt kernel: hci_acl_tx_to: hci0 killing stalled ACL<br> connection 2C:60:F9:52:1E:00<br> <br> I can make the keyboard work again by re-plugging the USB dongle and<br>
 waking up the keyboard.<br> <br> Anyway, I am going to try to get a USB bluetooth dongle that has a HID<br> proxy mode, and hopefully this can all be avoided.&nbsp;&nbsp;If anyone can<br> suggest a particular brand/model that is known to work in HID proxy<br>
 mode, please let me know!&nbsp;&nbsp;Thanks.<br> <br><br> <br> Phil.<br> <br> <br> <br> <br> <br> <br> <br> -------------------------------------------------------------------------<br> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference<br>
 Don&#39;t miss this year&#39;s exciting event. There&#39;s still time to save $100.<br> Use priority code J8TL2D2.<br> <a href="http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone">http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone</a><br>
 _______________________________________________<br> Bluez-users mailing list<br> <a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br> <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
 </blockquote></div><br>

------=_Part_32761_1816179.1208980223167--


--===============0666211883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0666211883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0666211883==--
