Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Capture HCI traffic between an embeddec BlueCore
	and Host
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1146125380.8784.39.camel@localhost>
References: <1146125380.8784.39.camel@localhost>
Content-Type: text/plain
Message-Id: <1147789954.24761.89.camel@localhost>
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
Date: Tue, 16 May 2006 16:32:34 +0200

Hi Ruud,

> As one might recall from an earlier mail from my colleague Han Hoekstra,
> I'm writing a HCI monitoring program in order to log the HCI
> communication between an embedded BC-Host combination. The goal of the
> program is to store the HCI packets in a file which has a format that
> can be reread and re-interpreted by the hcidump program. In reaction to
> this previous mail it was said that all information needed could be
> found in the hcidump program's source code.

why don't we extend hcidump to read the BCSP traffic?

> A second (seemingly) less important question is what the HCIDUMP
> HEADER's "pad" field stands for. I always see this one as being 0x00
> using hcidump so I just follow this in my program, but this is off
> course not very neat.

It is a padding field. Such fields are normal in protocol or file format
specification. They are supposed to be 0x00. A padding field can be used
to extend the format in the future without breaking the compatibility of
older programs.

Regards

Marcel




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
