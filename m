Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <419E805D.7010503@xmission.com>
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
	 <1100901846.7213.101.camel@pegasus>  <419E805D.7010503@xmission.com>
Content-Type: text/plain
Message-Id: <1100909377.7213.109.camel@pegasus>
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
Date: Sat, 20 Nov 2004 01:09:37 +0100

Hi Brad,

> Shouldn't this work to send the header in a separate write() and have a 
> struct for it?

no, because the L2CAP is a SOCK_SEQPACKET. You must send the packet at
once. Otherwise you will get bad fragmentation.

> I thought everything ended up being little-endian on the wire, but
> 
>      buf[2] = seq_num >> 8;
>      buf[3] = seq_num & 0xff;
> 
> looks big endian to me (00 then 01 for 0x0001). When my code writes to 
> sequence_number, it comes out little endian (01 then 00 for 0x0001).

Look at the RTP RFC they mentioned in the specification. I didn't
checked it. Simply used the stuff I've seen in my trace.

And btw the endianess may differ between parts of the Bluetooth protocol
stack. This is the problem when you adapt other protocols.

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
