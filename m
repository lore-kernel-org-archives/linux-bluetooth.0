Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <419E6AD8.7050104@xmission.com>
References: <418DB442.2050801@uen.org> <41925793.3050404@xmission.com>
	 <1100113055.25879.73.camel@pegasus> <419543B3.8050601@xmission.com>
	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>
	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>
	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <1100822368.7164.98.camel@pegasus>  <419DB6E1.8000203@xmission.com>
	 <1100864484.7213.19.camel@pegasus>  <419E20C3.7@xmission.com>
	 <1100883199.7213.27.camel@pegasus>  <1100885959.7213.31.camel@pegasus>
	 <1100897144.7213.63.camel@pegasus>  <419E6AD8.7050104@xmission.com>
Content-Type: text/plain
Message-Id: <1100901846.7213.101.camel@pegasus>
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
Date: Fri, 19 Nov 2004 23:04:06 +0100

Hi Brad,

> I added rcplay.c to cvs and made you a developer on bluetooth-alsa so 
> you can tweak things if you see fit.

thanks. I will do that.

> The bluetake sometimes works and sometimes doesn't when using a2play. 
> The same stream will work a couple of times and then it produces loud 
> white noise. There is probably something still not quite right.
> 
> I disabled this section in a2dp.c
> 
>    memset(buf, 0, 12);
>    buf[0] = 0x80;
>    buf[2] = seq_num >> 8;
>    buf[3] = seq_num & 0xff;
>    buf[12] = 0x0ff;
>    buf[13] = 0x0ff;
>    memcpy(buf + 14, &sbc_info, sizeof(sbc_info));
>    size = read(fd, buf + 14 + sizeof(sbc_info), mtu - sizeof(sbc_info) - 
> 14);
>    write(streamfd, buf, size + 14 + sizeof(sbc_info));
>    seq_num++;
> 
> but it didn't help or hurt. I couldn't see why sbc_info was being 
> written to the stream since I thought it was just a file header. Does 
> your headset work with a2play as it is in cvs now?

Yes, perfect. I tried it with an MP3 that I convert to a wave file and
used the sbc_encoder.exe to create the SBC file. It also works fine with
the rcplay tool.

I think that GCT (the company that build the chips and wrote the
software for both headphone types) added their own SBC media packet
format. I read the A2DP specification again and as far as I understand
it, we must read the SBC frame header from the first frame. Set the
AVDTP configuration according to that header and then send the SBC frame
with the SBC media packet header (with or without fragmenting). And then
proceed with the other SBC frames in that file.

I found nothing about 0xff 0xff and even playing with content protection
and multiplexing bits and bytes, nothing resulted in these two bytes.

What we need is an easy way to calculate the frame size from the frame
header without decoding the frame data itself. And also scanning for the
sync byte is not really an option. If we get this working, we need to
check if these headphones also support real A2DP media packets.

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
