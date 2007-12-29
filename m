Return-Path: <cyrus@holtmann.org>
Message-ID: <477623AE.7030107@yahoo.es>
Date: Sat, 29 Dec 2007 11:38:38 +0100
From: Perki Pat <perki_pat3@yahoo.es>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47754D1D.9020907@yahoo.es>
	<1198881591.4455.30.camel@aeonflux>	<4775870C.4030304@yahoo.es>
	<1198904400.4455.34.camel@aeonflux>
In-Reply-To: <1198904400.4455.34.camel@aeonflux>
Subject: Re: [Bluez-devel] hcitool and argv syntax
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1669484538=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1669484538==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> 
> You have to use "return 0". Otherwise you get a compiler warning.
I got no warning with GCC 4.1.3. Anyways, here is the new patch:

--- hcitool.c.orig	2007-12-28 20:06:58.000000000 +0100
+++ hcitool.c	2007-12-29 11:35:00.000000000 +0100
@@ -2329,5 +2329,11 @@
 		command[i].func(dev_id, argc, argv);
 		break;
 	}
+
+	if(!command[i].cmd) {
+		fprintf(stderr, "\"%s\" isn't a valid command. Try --help for a list
of commands.\n", argv[0]);
+		exit(1);
+	}
+
 	return 0;
 }

		
______________________________________________ 
LLama Gratis a cualquier PC del Mundo. 
Llamadas a fijos y móviles desde 1 céntimo por minuto. 
http://es.voice.yahoo.com



--===============1669484538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1669484538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1669484538==--
