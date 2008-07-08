Return-Path: <cyrus@holtmann.org>
Message-ID: <4873BB89.5030109@aircable.net>
Date: Tue, 08 Jul 2008 16:10:01 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48728258.6080809@aircable.net>
	<1215549694.26279.6.camel@californication>
In-Reply-To: <1215549694.26279.6.camel@californication>
Subject: Re: [Bluez-devel] No more binary SDP registration in new 4.0 API?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,
> the idea is not to use binary SDP records at all anymore. Also we wanna
> move the record registration and service authorization into a plugin and
> don't have this in the Adapter interface anymore.
>   
Ok got it. So then to work with binary records you should use bluelib 
right? Or this is going to be deprecated too?.

Thing is that in cases like BIP you wanna work with binary stuff, 
embedding xml records in your code might not be a good idea at all.

In fact the patch I created was to start making obex-data-server use the 
new API, but this was some how a boomer. What shall we do? Use sdplib, 
or go with xml strings?

Thanks,
Manuel

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
