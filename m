Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <419DB6E1.8000203@xmission.com>
References: <418DB442.2050801@uen.org> <41925793.3050404@xmission.com>
	 <1100113055.25879.73.camel@pegasus> <419543B3.8050601@xmission.com>
	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>
	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>
	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <1100822368.7164.98.camel@pegasus>  <419DB6E1.8000203@xmission.com>
Content-Type: text/plain
Message-Id: <1100864484.7213.19.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 19 Nov 2004 12:41:24 +0100

Hi Brad,

> I cleaned up the bitfields for the avdtp packets and committed it...
> 
> Do you think this looks right for covering the header on avdtp page 45?
> 
> // remember htobs() for converting from host to bluetooth byte ordering
> // when putting data in this struct
> typedef struct {
>    uint8_t v:2;
>    uint8_t p:1;
>    uint8_t x:1;
>    uint8_t cc:4;
>    uint8_t m:1;
>    uint8_t pt:7;
>    uint16_t sequence_number;
>    uint32_t timestamp;
>    uint32_t ssrc;
>    uint32_t csrc[0];
> } __attribute__ ((packed)) media_packet_header;
> 
> If that looks like the right direction, I need to work on delineating 
> the sbc frames inside the sbc file so i can put on the media packet 
> headers and the media payload headers. Is it straightforward?

this looks ok to me. From the trace of my Aiptek set I saw that these
header is filled with the following values:

	0x80 0x00 0x00 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00

So they only use the sequence number and nothing more. The next two
bytes are always 0xff 0xff and then the payload differs. After that I
see the 0x9c sync byte from the SBC file.

So what I think is that you can simply put the header and the other two
bytes into a L2CAP packet and then add as much data from the SBC file as
the MTU allows.

If the SBC frame header is always repeated I don't understand why we
need to set a specific SBC configuration with AVDTP.

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
https://lists.sourceforge.net/lists/listinfo/bluez-devel
