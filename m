Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <cbf0aec9041119165015fd6857@mail.gmail.com>
References: <418DB442.2050801@uen.org> <1100864484.7213.19.camel@pegasus>
	 <419E20C3.7@xmission.com> <1100883199.7213.27.camel@pegasus>
	 <1100885959.7213.31.camel@pegasus> <1100897144.7213.63.camel@pegasus>
	 <419E6AD8.7050104@xmission.com> <1100901846.7213.101.camel@pegasus>
	 <cbf0aec9041119160441592e2c@mail.gmail.com>
	 <1100911396.7213.111.camel@pegasus>
	 <cbf0aec9041119165015fd6857@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1100927065.7213.117.camel@pegasus>
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
Date: Sat, 20 Nov 2004 06:04:25 +0100

Hi Henryk,

> > btw what is the format of sbc_test_01.sbc etc. Do we have a specific
> > list of the settings in these files. I like to put it for reference on
> > the web.
> 
> Yupp, that's in A2DP_TS_C1.1v10.pdf on pages 34 and following.

I've added a tool called sbcinfo to the CVS that goes through a SBC file
and decodes this information. I also updated a2play and rcplay to make
use of the SBC frame length.

However I was unable to get my Aiptek headphone to play some music with
the original SBC media header.

And btw the AVDTP parser in the hcidump CVS repository should now be
able to display the correct decoded information on the signal channel.

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
