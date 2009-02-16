Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BAY114-DS16A8C9E600F64096D25D4B1B70@phx.gbl>
References: <6887eb5d0902140405x11b91ad2o8471954cabc64d7c@mail.gmail.com>
	 <BAY114-DS2DC8ADEB0A7BCA5D29E62B1B70@phx.gbl>
	 <6b53b1990902152203r4fa9e50ajcc5d050c2ee3b5b8@mail.gmail.com>
	 <BAY114-DS16A8C9E600F64096D25D4B1B70@phx.gbl>
Date: Mon, 16 Feb 2009 09:46:21 -0300
Message-ID: <6b53b1990902160446s14960c17j32da4f778d623234@mail.gmail.com>
Subject: Re: OBEX profile support
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: shy <shyboysby@hotmail.com>
Cc: Kartikey Parmar <kartikey2781@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=GB2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Feb 16, 2009 at 3:24 AM, shy <shyboysby@hotmail.com> wrote:
> Hi,
> You need openobex compiled firstly, and then you could use obexftp to do
> file transfer. Openobex and obexftp support bluetooth channel.
> Brs

I have openobex compiled, but obexftp fail to compile due to its bluetooth code.

if gcc -DHAVE_CONFIG_H -I. -I. -I.. -I.. -I../includes    -g -O2 -W
-Wundef -Wmissing-declarations -Wmissing-prototypes -Wall -MT
obexftpd.o -MD -MP -MF ".deps/obexftpd.Tpo" -c -o obexftpd.o
obexftpd.c; \
        then mv -f ".deps/obexftpd.Tpo" ".deps/obexftpd.Po"; else rm
-f ".deps/obexftpd.Tpo"; exit 1; fi
obexftpd.c:81: error: expected '=', ',', ';', 'asm' or '__attribute__'
before '*' token
obexftpd.c: In function 'start_server':
obexftpd.c:891: warning: implicit declaration of function
'BtOBEX_ServerRegister'
obexftpd.c:891: error: 'bt_src' undeclared (first use in this function)
obexftpd.c:891: error: (Each undeclared identifier is reported only once
obexftpd.c:891: error: for each function it appears in.)




> Shi Buyun
>
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org
> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Gustavo F.
> Padovan
> Sent: 2009年2月16日 14:04
> To: shy
> Cc: Kartikey Parmar; linux-bluetooth@vger.kernel.org
> Subject: Re: OBEX profile support
>
> Hi,
>
> 2009/2/16 shy <shyboysby@hotmail.com>:
>> Hi, Kartikey
>> You can use obexftp to do your task. You can find obexftp in folder
>> /obexftp/apps.
>
> I have the same doubt: how to transfer files. I find out obexftp, but does
> it support BlueZ 4.x? Version 0.22 of obexftp not even compile with BlueZ 4.
> x.
> And what folder is that? Where can I find it?
>
>> Brs
>> Shi Buyun
>>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org
>> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Kartikey
>> Parmar
>> Sent: 2009年2月14日 20:05
>> To: linux-bluetooth@vger.kernel.org
>> Subject: OBEX profile support
>>
>> hi
>>
>> I want to support file transfer between two bluetooth devices (say
>> mobile phone & desktop pc) in my application...
>> Is there any utility bluez provides on which I can test first whether
>> it is working or not! like
>>
>> hcitool, sdptool etc...or I will have to work on some utility to
>> implement OBEX???
>>
>> pls reply if somebody has done this...
>>
>> --
>> Kartikey Parmar
>> President AAECC
>> 09879095390 (M)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> Gustavo F. Padovan
>
> Computer Engineering Student
> Institute of Computing - IC
> University of Campinas - UNICAMP
>
> email: gustavo@las.ic.unicamp.br
> gtalk: gfpadovan@gmail.com
> mobile: +55 19 81030803
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
>
>



-- 
Gustavo F. Padovan

Computer Engineering Student
Institute of Computing - IC
University of Campinas - UNICAMP

email: gustavo@las.ic.unicamp.br
gtalk: gfpadovan@gmail.com
mobile: +55 19 81030803
