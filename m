Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41970F25.4020902@xmission.com>
References: <418DB442.2050801@uen.org> <1099830449.6896.14.camel@pegasus>
	 <418E4E9C.8070100@xmission.com> <1099846462.6896.26.camel@pegasus>
	 <418E6FBF.3090409@xmission.com> <1099863224.6896.57.camel@pegasus>
	 <4191AB4B.8060701@xmission.com> <1100076431.25879.49.camel@pegasus>
	 <41925793.3050404@xmission.com> <1100113055.25879.73.camel@pegasus>
	 <419543B3.8050601@xmission.com> <1100306337.7349.29.camel@pegasus>
	 <41957BC1.507@xmission.com> <1100351199.7349.50.camel@pegasus>
	 <41970F25.4020902@xmission.com>
Content-Type: text/plain
Message-Id: <1100446172.21403.16.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 14 Nov 2004 16:29:32 +0100

Hi Brad,

> Argh... I'm stuck again. the avdtp_set_configuration command goes out 
> but reading the response just blocks. I'm not sure what is wrong... I send:
> 
>   00 -> header = request
>   03 -> AVDTP_SET_CONFIGURATION
>   04 -> acp_seid = 1
>   04 -> int_seid = 1 (how should I choose the int_seid?)
>   01 -> service category = media transport
>   00 -> length of service capabilities = 0
>   07 -> capability type = media codec
>   06 -> bytes remaining? not sure if this is right.
>   00 -> media type = audio media type
>   00 -> media codec type = SBC
>   22 -> 44.1khz stereo
>   15 -> 16-byte blocks, 8 subbands, "loudness" allocation
>   02 -> min bitpool
>   fa -> max bitpool

I think you really need to fill in the transaction number in the header
byte. So it should be 0x00, 0x10, 0x20, 0x30 etc.

The bytes remaining value is right.

>>From sniffing the connection between the sender and receiver of my
Aiptek devices I see that they use 0x22 0x46 for the SBC setting. And
this is 44.1kHz, stereo, blocklen 64, 8 subbands, SNR if I decoded it
correct.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
