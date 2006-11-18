Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <adf2d65c0611180343n2c25a77fv6753d87cb7fe772b@mail.gmail.com>
Date: Sat, 18 Nov 2006 12:43:54 +0100
From: Arthur <avandorp@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061118110247.10397.qmail@web52105.mail.yahoo.com>
MIME-Version: 1.0
References: <20061118110247.10397.qmail@web52105.mail.yahoo.com>
Subject: Re: [Bluez-users] Errors pairing with headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0973124342=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0973124342==
Content-Type: multipart/alternative;
	boundary="----=_Part_12030_18007458.1163850234124"

------=_Part_12030_18007458.1163850234124
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Paolo

Trying to connect to my bluetooth headset on a new Ubuntu Edgy install
> (have'nt touched any of the /etc/bluetooth/*.conf files)
>
> I looked at https://help.ubuntu.com/community/BluetoothSetup for guidance
>
> When my headseat is in pairing mode, if try
>
>     sudo hidd --search
>
I get totally no output, not even the "No devices in range or visible" that
> I get when the headset is off.

But if I try
>       sudo hcitool scan
> then my headest is recognized
>       aa:bb:cc:dd:ee:ff       BT Headset-12
> If I try then
>       sudo hidd --connect  aa:bb:cc:dd:ee:ff
> I get the error message
>     Can't get device information: Permission denied


I've never bothered with the hidd stuff. I do get the same "No devices..."
message for hidd --search with my headset turned on even though it works
just fine.

I've just install the bluez-btsco package (sudo aptitude install
bluez-btsco). Try running
btsco -v aa:bb:cc:dd:ee:ff
and  see whether it can connect to your headset. The first time you do this,
you should be prompted for the pin.

Good luck

Arthur

------=_Part_12030_18007458.1163850234124
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Paolo<br><div><span class="gmail_quote"><br></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Trying to connect to my bluetooth headset on a new Ubuntu Edgy install (have'nt touched any of the /etc/bluetooth/*.conf files)
<br><br>I looked at <a href="https://help.ubuntu.com/community/BluetoothSetup">https://help.ubuntu.com/community/BluetoothSetup</a> for guidance<br><br>When my headseat is in pairing mode, if try<br><br>&nbsp;&nbsp;&nbsp;&nbsp;sudo hidd --search 
<br></blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I get totally no output, not even the &quot;No devices in range or visible&quot; that I get when the headset is off.
</blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">But if I try<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sudo hcitool scan<br>then my headest is recognized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aa:bb:cc:dd:ee:ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BT Headset-12
<br>If I try then<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sudo hidd --connect&nbsp;&nbsp;aa:bb:cc:dd:ee:ff<br>I get the error message<br>&nbsp;&nbsp;&nbsp;&nbsp;Can't get device information: Permission denied</blockquote><div><br>I've never bothered with the hidd stuff. I do get the same &quot;No devices...&quot; message for hidd --search with my headset turned on even though it works just fine.
<br><br>I've just install the bluez-btsco package (sudo aptitude install bluez-btsco). Try running<br>btsco -v aa:bb:cc:dd:ee:ff<br>and&nbsp; see whether it can connect to your headset. The first time you do this, you should be prompted for the pin.
<br><br>Good luck<br><br>Arthur<br><br></div><br></div><br>

------=_Part_12030_18007458.1163850234124--


--===============0973124342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0973124342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0973124342==--
