Return-Path: <cyrus@holtmann.org>
Message-ID: <5eee8c670804220813m351b6d10l57ad21bd34c812f0@mail.gmail.com>
Date: Tue, 22 Apr 2008 16:13:02 +0100
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1208876324686@dmwebmail.dmwebmail.chezphil.org>
MIME-Version: 1.0
References: <1208876324686@dmwebmail.dmwebmail.chezphil.org>
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
Content-Type: multipart/mixed; boundary="===============0532267938=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0532267938==
Content-Type: multipart/alternative;
	boundary="----=_Part_24075_5090218.1208877182766"

------=_Part_24075_5090218.1208877182766
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

You're probably suffering from the following bug:

https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394

Try a 'hciconfig hci0 reset' after restarting and then your keyboard should
reconnect again.

Alex

On 22/04/2008, Phil Endecott <spam_from_bluez_users@chezphil.org> wrote:
>
> Dear Bluetooth experts,
>
> I think I am probably the bazillionth person to ask here about how to
> get the Apple wireless keyboard to work properly with Linux.  Some of
> the people who've solved the problem before have posted how-to pages
> with recipes that worked for them, but unfortunately without really
> understanding what was going on, or containing distribution-specific or
> out-of-date information.  My keyboard is basically working now, but I'm
> hoping that you can help me to understand what is really going on and
> what is the right way to do it.
>
> Firstly, I understand that some USB Bluetooth dongles have a "HID Mode"
> where they appear as USB HID devices and all of the Bluetooth
> complexity is avoided.  That would be ideal for me, but I suspect that
> my dongle doesn't support that mode of operation; this page:
> http://times.usefulinc.com/2004/06/12-hidproxy says that (in 2004) only
> the CSR chips had this feature; is this still true?  My dongle is
> (lsusb) "1131:1004 Integrated System Solution Corp." which doesn't look
> like CSR.  I bought it cheapo on Ebay.  Is there a reliable way to
> obtain a USB dongle with a CSR chip with this feature?  And how does
> pairing work in this HID mode?  (Is it secure?)
>
> Anyway, for the time being I have set it up the "hard way" as a real
> Bluetooth keyboard.  I did this by
>
> - Installing a kernel with the bluetooth modules.
> - Installing bluez-utils.
> - Starting hidd and hcid (enabling them in /etc/default/bluetooth on
> this Debian box)
> - Running passkey-agent --default 1234 (Debian ships this source for this)
> - Running hcitool scan to get the keyboard address (which I've now
> written on the back)
> - Running hidd --connect <addr> and typing 1234RET on the keyboard
>
> Now, if I understand things correctly, this PIN pairing should be a
> one-off thing; there is now a file in /var/lib/bluetooth/..../linkkeys
> which I presume is a key that can be used subsequently instead of the
> PIN procedure - right?  (BTW, the .... in the pathname above is not the
> keyboard's address; it has lots of 0s at the end.  What is it?)  So
> after I reboot the keyboard should be able to connect without user
> interaction.  But so far I have failed to make this happen.  I have
> only been able to reconnect by deleting various things and starting
> from fresh.  What do I need to do?  Do I need to add it to a
> configuration file somewhere?  Do I need to arrange for hidd --connect
> to be run?
>
> Many thanks for any suggestions.
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

------=_Part_24075_5090218.1208877182766
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

You&#39;re probably suffering from the following bug:<br><br><a href="https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394">https://bugs.launchpad.net/ubuntu/+source/bluez-utils/+bug/79394</a><br><br>Try a &#39;hciconfig hci0 reset&#39; after restarting and then your keyboard should reconnect again.<br>
<br>Alex<br><br><div><span class="gmail_quote">On 22/04/2008, <b class="gmail_sendername">Phil Endecott</b> &lt;<a href="mailto:spam_from_bluez_users@chezphil.org">spam_from_bluez_users@chezphil.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dear Bluetooth experts,<br> <br> I think I am probably the bazillionth person to ask here about how to<br> get the Apple wireless keyboard to work properly with Linux.&nbsp;&nbsp;Some of<br> the people who&#39;ve solved the problem before have posted how-to pages<br>
 with recipes that worked for them, but unfortunately without really<br> understanding what was going on, or containing distribution-specific or<br> out-of-date information.&nbsp;&nbsp;My keyboard is basically working now, but I&#39;m<br>
 hoping that you can help me to understand what is really going on and<br> what is the right way to do it.<br> <br> Firstly, I understand that some USB Bluetooth dongles have a &quot;HID Mode&quot;<br> where they appear as USB HID devices and all of the Bluetooth<br>
 complexity is avoided.&nbsp;&nbsp;That would be ideal for me, but I suspect that<br> my dongle doesn&#39;t support that mode of operation; this page:<br> <a href="http://times.usefulinc.com/2004/06/12-hidproxy">http://times.usefulinc.com/2004/06/12-hidproxy</a> says that (in 2004) only<br>
 the CSR chips had this feature; is this still true?&nbsp;&nbsp;My dongle is<br> (lsusb) &quot;1131:1004 Integrated System Solution Corp.&quot; which doesn&#39;t look<br> like CSR.&nbsp;&nbsp;I bought it cheapo on Ebay.&nbsp;&nbsp;Is there a reliable way to<br>
 obtain a USB dongle with a CSR chip with this feature?&nbsp;&nbsp;And how does<br> pairing work in this HID mode?&nbsp;&nbsp;(Is it secure?)<br> <br> Anyway, for the time being I have set it up the &quot;hard way&quot; as a real<br> Bluetooth keyboard.&nbsp;&nbsp;I did this by<br>
 <br> - Installing a kernel with the bluetooth modules.<br> - Installing bluez-utils.<br> - Starting hidd and hcid (enabling them in /etc/default/bluetooth on<br> this Debian box)<br> - Running passkey-agent --default 1234 (Debian ships this source for this)<br>
 - Running hcitool scan to get the keyboard address (which I&#39;ve now<br> written on the back)<br> - Running hidd --connect &lt;addr&gt; and typing 1234RET on the keyboard<br> <br> Now, if I understand things correctly, this PIN pairing should be a<br>
 one-off thing; there is now a file in /var/lib/bluetooth/..../linkkeys<br> which I presume is a key that can be used subsequently instead of the<br> PIN procedure - right?&nbsp;&nbsp;(BTW, the .... in the pathname above is not the<br>
 keyboard&#39;s address; it has lots of 0s at the end.&nbsp;&nbsp;What is it?)&nbsp;&nbsp;So<br> after I reboot the keyboard should be able to connect without user<br> interaction.&nbsp;&nbsp;But so far I have failed to make this happen.&nbsp;&nbsp;I have<br> only been able to reconnect by deleting various things and starting<br>
 from fresh.&nbsp;&nbsp;What do I need to do?&nbsp;&nbsp;Do I need to add it to a<br> configuration file somewhere?&nbsp;&nbsp;Do I need to arrange for hidd --connect<br> to be run?<br> <br> Many thanks for any suggestions.<br> <br> Phil.<br> <br> <br>
 <br> <br> <br> <br> <br> -------------------------------------------------------------------------<br> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference<br> Don&#39;t miss this year&#39;s exciting event. There&#39;s still time to save $100.<br>
 Use priority code J8TL2D2.<br> <a href="http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone">http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone</a><br> _______________________________________________<br>
 Bluez-users mailing list<br> <a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br> <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
 </blockquote></div><br>

------=_Part_24075_5090218.1208877182766--


--===============0532267938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============0532267938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0532267938==--
