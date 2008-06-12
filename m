Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Jun 2008 10:49:59 +0800 (CST)
From: attaboyu@163.com
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Message-ID: <20419813.1056881213238999944.JavaMail.coremail@bj163app77.163.com>
In-Reply-To: <01a301c8cb66$dea24ba0$0132a8c0@Raymondpc>
References: <01a301c8cb66$dea24ba0$0132a8c0@Raymondpc>
	<118473.25603.qm@web57908.mail.re3.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] How to use Bluez with CSR chip ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1104607381=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1104607381==
Content-Type: multipart/alternative;
	boundary="----=_Part_279934_31628759.1213238999942"

------=_Part_279934_31628759.1213238999942
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: quoted-printable

   hi raymond
the csr bc4 need to be configured before real running, some pskey should be=
 set and warmreset should be issued.=20
1. add --enable-bccmd feature while configure the bluez-utils
2. use bccmd after hci0 is up:
    $bccmd -t hci psload -r /csr.psr
     here csr.psr is the pskey config file, -r means warmreset after pskey =
configured,there is a example psr file in bluez-utils/tools/example

after that, u can see the other device through hcitool scan

attaboyu

 =D4=DA2008-06-11=A3=ACcolorant <colorant@163.com> =D0=B4=B5=C0=A3=BA
>Hi henry
>
>    Thanks for you reply.
>
>    Yes , I am using BC4 A06 Rom version on an arm based embedded board.
>
>    So this one must set pskey before running right ?
>
>    I try to run the CSR's demo first to set the right pskey and run the=
=20
>chip up.
>    After I exit the demo, I can use pc to detect the chip.
>
>    While , then I use :
>
>    hciattach /dev/ttyS1 bcsp 921600
>
>    to attach ttyS1 to hci0
>
>    after that , The PC can not detect the chip anymore.
>
>    and then I try
>    hciconfig hci0 up
>    it can bring up the hci0 interface , but the pc still don't detect the=
=20
>chip.
>
>    for kernel , I only insert bluetooth.ko and hci_uart.ko
>
>    So , can you kindly figure out what might be wrong in my operation ?
>
>    Seems to me the hciattach operation reset the chip. And I might need t=
o=20
>modify the hciattach , or ?
>
>Raymond
>
>----- Original Message -----=20
>From: "hong zhang"=20
>To: "BlueZ users"=20
>Sent: Wednesday, June 11, 2008 8:57 AM
>Subject: Re: [Bluez-users] How to use Bluez with CSR chip ?
>
>
>> Raymond,
>>
>> CSR bc4 is initialized in two ways based on your
>> design. I assum your board is embedded. One is by
>> eeprom and one is using command after build. You need
>> to provide more information.
>>
>> You have to make sure your CSR bc4 chip on your board
>> is up first before using bluez.
>>
>> Regular talking here is based on x86.
>>
>> ---henry
>>
>> --- colorant  wrote:
>>
>>> Hi
>>>
>>>     I am not sure is this the proper place to put up
>>> this question, if not ,
>>> please correct me.
>>>
>>>     I was trying to run bluez on our board with bc4
>>> chip. This chip need to
>>> set pskey before it can run
>>>
>>>     I use hciattach and hciconfig to bring up the
>>> hci0 interface.
>>>
>>>     Then I try hcitool hci0 scan with my earphone
>>> open.
>>>
>>>     Nothing happend.
>>>
>>>     while, if I using CSR's bchs a2dp demo , it's
>>> ok, I can play music. say
>>> hardware is ok.
>>>
>>>     My question is :
>>>
>>>     1. To enable bluez with csr chip, is there
>>> anything need to do vs the
>>> standard kernel and bluez package ? Some config
>>> need?
>>>
>>>     2. Did I need to place the bootrap init sequence
>>> for the bc4 chip in
>>> some place if I using bluez ? say in kernel or in
>>> the bluez user space
>>> scripts? Or , the standard kernel and bluez utility
>>> already hand it, But I
>>> just do the wrong way ?
>>>
>>>
>>> Many thanks.
>>> Raymond
>>>
>>>
>>>
>>>
>>>
>> ------------------------------------------------------------------------=
-
>>> Check out the new SourceForge.net Marketplace.
>>> It's the best place to buy or sell services for
>>> just about anything Open Source.
>>> http://sourceforge.net/services/buy/index.php
>>> _______________________________________________
>>> Bluez-users mailing list
>>> Bluez-users@lists.sourceforge.net
>>>
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>
>>
>>
>>
>>
>>
>> ------------------------------------------------------------------------=
-
>> Check out the new SourceForge.net Marketplace.
>> It's the best place to buy or sell services for
>> just about anything Open Source.
>> http://sourceforge.net/services/buy/index.php
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>=20
>
>
>
>
>-------------------------------------------------------------------------
>Check out the new SourceForge.net Marketplace.
>It's the best place to buy or sell services for
>just about anything Open Source.
>http://sourceforge.net/services/buy/index.php
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_Part_279934_31628759.1213238999942
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

   hi raymond<br>the csr bc4 need to be configured before real running, som=
e pskey should be set and warmreset should be issued. <br>1. add --enable-b=
ccmd feature while configure the bluez-utils<br>2. use bccmd after hci0 is =
up:<br>    $bccmd -t hci psload -r /csr.psr<br>     here csr.psr is the psk=
ey config file, -r means warmreset after pskey configured,there is a exampl=
e psr file in bluez-utils/tools/example<br><br>after that, u can see the ot=
her device through hcitool scan<br><br>attaboyu<br><br> =D4=DA2008-06-11=A3=
=ACcolorant &lt;colorant@163.com&gt; =D0=B4=B5=C0=A3=BA<br>&gt;Hi henry<br>=
&gt;<br>&gt;    Thanks for you reply.<br>&gt;<br>&gt;    Yes , I am using B=
C4 A06 Rom version on an arm based embedded board.<br>&gt;<br>&gt;    So th=
is one must set pskey before running right ?<br>&gt;<br>&gt;    I try to ru=
n the CSR's demo first to set the right pskey and run the <br>&gt;chip up.<=
br>&gt;    After I exit the demo, I can use pc to detect the chip.<br>&gt;<=
br>&gt;    While , then I use :<br>&gt;<br>&gt;    hciattach /dev/ttyS1 bcs=
p 921600<br>&gt;<br>&gt;    to attach ttyS1 to hci0<br>&gt;<br>&gt;    afte=
r that , The PC can not detect the chip anymore.<br>&gt;<br>&gt;    and the=
n I try<br>&gt;    hciconfig hci0 up<br>&gt;    it can bring up the hci0 in=
terface , but the pc still don't detect the <br>&gt;chip.<br>&gt;<br>&gt;  =
  for kernel , I only insert bluetooth.ko and hci_uart.ko<br>&gt;<br>&gt;  =
  So , can you kindly figure out what might be wrong in my operation ?<br>&=
gt;<br>&gt;    Seems to me the hciattach operation reset the chip. And I mi=
ght need to <br>&gt;modify the hciattach , or ?<br>&gt;<br>&gt;Raymond<br>&=
gt;<br>&gt;----- Original Message ----- <br>&gt;From: "hong zhang" <br>&gt;=
To: "BlueZ users" <br>&gt;Sent: Wednesday, June 11, 2008 8:57 AM<br>&gt;Sub=
ject: Re: [Bluez-users] How to use Bluez with CSR chip ?<br>&gt;<br>&gt;<br=
>&gt;&gt; Raymond,<br>&gt;&gt;<br>&gt;&gt; CSR bc4 is initialized in two wa=
ys based on your<br>&gt;&gt; design. I assum your board is embedded. One is=
 by<br>&gt;&gt; eeprom and one is using command after build. You need<br>&g=
t;&gt; to provide more information.<br>&gt;&gt;<br>&gt;&gt; You have to mak=
e sure your CSR bc4 chip on your board<br>&gt;&gt; is up first before using=
 bluez.<br>&gt;&gt;<br>&gt;&gt; Regular talking here is based on x86.<br>&g=
t;&gt;<br>&gt;&gt; ---henry<br>&gt;&gt;<br>&gt;&gt; --- colorant  wrote:<br=
>&gt;&gt;<br>&gt;&gt;&gt; Hi<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;     I am not s=
ure is this the proper place to put up<br>&gt;&gt;&gt; this question, if no=
t ,<br>&gt;&gt;&gt; please correct me.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;     =
I was trying to run bluez on our board with bc4<br>&gt;&gt;&gt; chip. This =
chip need to<br>&gt;&gt;&gt; set pskey before it can run<br>&gt;&gt;&gt;<br=
>&gt;&gt;&gt;     I use hciattach and hciconfig to bring up the<br>&gt;&gt;=
&gt; hci0 interface.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;     Then I try hcitool=
 hci0 scan with my earphone<br>&gt;&gt;&gt; open.<br>&gt;&gt;&gt;<br>&gt;&g=
t;&gt;     Nothing happend.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;     while, if I=
 using CSR's bchs a2dp demo , it's<br>&gt;&gt;&gt; ok, I can play music. sa=
y<br>&gt;&gt;&gt; hardware is ok.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;     My qu=
estion is :<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;     1. To enable bluez with csr=
 chip, is there<br>&gt;&gt;&gt; anything need to do vs the<br>&gt;&gt;&gt; =
standard kernel and bluez package ? Some config<br>&gt;&gt;&gt; need?<br>&g=
t;&gt;&gt;<br>&gt;&gt;&gt;     2. Did I need to place the bootrap init sequ=
ence<br>&gt;&gt;&gt; for the bc4 chip in<br>&gt;&gt;&gt; some place if I us=
ing bluez ? say in kernel or in<br>&gt;&gt;&gt; the bluez user space<br>&gt=
;&gt;&gt; scripts? Or , the standard kernel and bluez utility<br>&gt;&gt;&g=
t; already hand it, But I<br>&gt;&gt;&gt; just do the wrong way ?<br>&gt;&g=
t;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Many thanks.<br>&gt;&gt;&gt; Raymond=
<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt;&gt;<br>&gt;&gt=
;&gt;<br>&gt;&gt; ---------------------------------------------------------=
----------------<br>&gt;&gt;&gt; Check out the new SourceForge.net Marketpl=
ace.<br>&gt;&gt;&gt; It's the best place to buy or sell services for<br>&gt=
;&gt;&gt; just about anything Open Source.<br>&gt;&gt;&gt; http://sourcefor=
ge.net/services/buy/index.php<br>&gt;&gt;&gt; _____________________________=
__________________<br>&gt;&gt;&gt; Bluez-users mailing list<br>&gt;&gt;&gt;=
 Bluez-users@lists.sourceforge.net<br>&gt;&gt;&gt;<br>&gt;&gt; https://list=
s.sourceforge.net/lists/listinfo/bluez-users<br>&gt;&gt;&gt;<br>&gt;&gt;<br=
>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt;<br>&gt;&gt; -----------------=
--------------------------------------------------------<br>&gt;&gt; Check =
out the new SourceForge.net Marketplace.<br>&gt;&gt; It's the best place to=
 buy or sell services for<br>&gt;&gt; just about anything Open Source.<br>&=
gt;&gt; http://sourceforge.net/services/buy/index.php<br>&gt;&gt; _________=
______________________________________<br>&gt;&gt; Bluez-users mailing list=
<br>&gt;&gt; Bluez-users@lists.sourceforge.net<br>&gt;&gt; https://lists.so=
urceforge.net/lists/listinfo/bluez-users<br>&gt;&gt; <br>&gt;<br>&gt;<br>&g=
t;<br>&gt;<br>&gt;---------------------------------------------------------=
----------------<br>&gt;Check out the new SourceForge.net Marketplace.<br>&=
gt;It's the best place to buy or sell services for<br>&gt;just about anythi=
ng Open Source.<br>&gt;http://sourceforge.net/services/buy/index.php<br>&gt=
;_______________________________________________<br>&gt;Bluez-users mailing=
 list<br>&gt;Bluez-users@lists.sourceforge.net<br>&gt;https://lists.sourcef=
orge.net/lists/listinfo/bluez-users<br><br><!-- footer --><br>=20
<hr>
<font style=3D"font-size:12px;line-height:15px;">=B0=C2=B1=B1=BA=CB=D0=C4 <=
/font><a style=3D"font-size:12px;line-height:15px; color:blue; text-decorat=
ion:underline;" href=3D"http://popme.163.com/link/3982_0612_3642.html">=CB=
=AB=B5=D8=CC=FA=BE=AB=D7=B0=D0=A1=BB=A7=D0=CD</a>
------=_Part_279934_31628759.1213238999942--



--===============1104607381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1104607381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1104607381==--
