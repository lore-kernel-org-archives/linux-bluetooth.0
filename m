Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AADP -- Is it being worked on?
From: Marcel Holtmann <marcel@holtmann.org>
To: Aarti Kumar <akmr2000@yahoo.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   "Sundar, Murali" <murali.sundar@intel.com>
In-Reply-To: <20040203075757.42952.qmail@web10206.mail.yahoo.com>
References: <20040203075757.42952.qmail@web10206.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1075808154.13285.7.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 03 Feb 2004 12:35:54 +0100

Hi Aarti,

> I am working on the implementation of A2DTP with basic
> functionality and right now the raw version is working
> with MP3 codec. But to be included on the bluez
> protocol stack I have to add SBC and refine it. I am
> not working on AADP, though I have written an
> application based on AADP with MP3 codec to test AVDTP
> functionality. 

to get A2DP working we need a clean AVDTP implementation which we can
include into BlueZ. This is the basic step and I don't care if you use a
MP3 codec or SBC. Once AVDTP is in the right shape, the rest will follow
automaticly. Do you have code we can look at?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
