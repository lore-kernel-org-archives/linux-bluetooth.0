Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0805200952v87c4bf7q45afc5e5e0af033@mail.gmail.com>
Date: Tue, 20 May 2008 18:52:27 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <3e9cdced0805200428w4bb37ae6xd95094f33a583a39@mail.gmail.com>
MIME-Version: 1.0
References: <3e9cdced0805200104nf8cbc16r24ac63f874c8e9d0@mail.gmail.com>
	<3e9cdced0805200428w4bb37ae6xd95094f33a583a39@mail.gmail.com>
Subject: Re: [Bluez-users] Cant receive signals from Adapter (low-level dbus
	API)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0888208722=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0888208722==
Content-Type: multipart/alternative;
	boundary="----=_Part_445_32818865.1211302347227"

------=_Part_445_32818865.1211302347227
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well I've build everything again (kernel modules, and bluez lib and utils)
and the problem seems to be fixed at this point.
I go in to detail tomorrow.

--Fritz

On Tue, May 20, 2008 at 1:28 PM, Fritz Code <codefritz@googlemail.com>
wrote:

> Well I did some further investigation concerning this problem and can
> provide you more details.
> Bluez doesn't generate an event in cases it is supposed to.
> I have started the dbus-monitor, if I plug an USB BLuetooth dongle to my
> USB port dbus-monitor lists signal from /org/bluez.
> I also get a signal when i remove the device.
> But I can't see any activity on the dbus when ich e.g. scan for remote
> devices or if I change the name of the local device.
>
> Has anybody an idea why bluez doesn't emit the expected signals?
>
> thanks,
> Fritz
>
>
>
> On Tue, May 20, 2008 at 10:04 AM, Fritz Code <codefritz@googlemail.com>
> wrote:
>
>> Hi,
>>
>> attached is a small test application.
>> With this application I want to test the handling of signals from bluez
>> Adapter.
>> Therefore I always change the name of my bluetooth device, in order to
>> make the adapter to
>> generate a signal.
>> Unfortunately I cant receive this signal.
>> I can set and get the name correctly.
>> BUt it seems I receive at least some signals:
>> When I start the application I get a signal with value :1.20
>> If I remove my usb bluetooth dongle I get a signal with value off.
>>
>>
>>
>>
>> In another application I had the same problem (receiving not the expected
>> signals: e.g.: DiscoveryStarted() ... )
>>  when I sent signal DiscoverDevices.
>>
>>
>> thanks.
>>
>> --
>> Regards,
>> --Codefritz
>>
>>
>>
>>
>
>
> --
> Regards,
> --Codefritz
>
>
>
>


-- 
Regards,
--Codefritz

------=_Part_445_32818865.1211302347227
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Well I&#39;ve build everything again (kernel modules, and bluez lib and utils) and the problem seems to be fixed at this point.<br>I go in to detail tomorrow.<br><br>--Fritz<br><br><div class="gmail_quote">On Tue, May 20, 2008 at 1:28 PM, Fritz Code &lt;<a href="mailto:codefritz@googlemail.com">codefritz@googlemail.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Well I did some further investigation concerning this problem and can provide you more details.<br>
Bluez doesn&#39;t generate an event in cases it is supposed to.<br>I have started the dbus-monitor, if I plug an USB BLuetooth dongle to my USB port dbus-monitor lists signal from /org/bluez.<br>
I also get a signal when i remove the device.<br>But I can&#39;t see any activity on the dbus when ich e.g. scan for remote devices or if I change the name of the local device. <br><br>Has anybody an idea why bluez doesn&#39;t emit the expected signals?<br>

<br>thanks,<br>Fritz<div><div></div><div class="Wj3C7c"><br><br><br><div class="gmail_quote">On Tue, May 20, 2008 at 10:04 AM, Fritz Code &lt;<a href="mailto:codefritz@googlemail.com" target="_blank">codefritz@googlemail.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>attached is a small test application.<br>With this application I want to test the handling of signals from bluez Adapter.<br>Therefore I always change the name of my bluetooth device, in order to make the adapter to <br>


generate a signal.<br>Unfortunately I cant receive this signal.<br>I can set and get the name correctly.<br>BUt it seems I receive at least some signals:<br>When I start the application I get a signal with value :1.20<br>


If I remove my usb bluetooth dongle I get a signal with value off.<br><br><br><br><br>In another application I had the same problem (receiving not the expected signals: e.g.: DiscoveryStarted() ... )<br>&nbsp;when I sent signal DiscoverDevices.<br>


<br><br>thanks.<br><font color="#888888"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>
</font></blockquote></div><br><br clear="all"><br></div></div><font color="#888888">-- <br>Regards,<br>--Codefritz<br><br><br><br>
</font></blockquote></div><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_445_32818865.1211302347227--


--===============0888208722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0888208722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0888208722==--
