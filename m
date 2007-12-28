Return-Path: <cyrus@holtmann.org>
Message-ID: <4775870C.4030304@yahoo.es>
Date: Sat, 29 Dec 2007 00:30:20 +0100
From: Perki Pat <perki_pat3@yahoo.es>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47754D1D.9020907@yahoo.es> <1198881591.4455.30.camel@aeonflux>
In-Reply-To: <1198881591.4455.30.camel@aeonflux>
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
Content-Type: multipart/mixed; boundary="===============0827358740=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0827358740==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> your patch is way too complicated. You can simply check for
> command[i].cmd == NULL to print the error.
You're completely right. I don't know what I was thinking on.
> 
> And of course you have to follow the coding style. I am not joking with
> this one. It is the main reason for me to reject patches.
I've replaced 3-space-tabs with real tabs.

--- hcitool.c.orig	2007-12-28 20:06:58.000000000 +0100
+++ hcitool.c	2007-12-29 00:09:03.000000000 +0100
@@ -2329,5 +2329,11 @@
 		command[i].func(dev_id, argc, argv);
 		break;
 	}
-	return 0;
+
+	if(!command[i].cmd) {
+		fprintf(stderr, "\"%s\" isn't a valid command. Try --help for a list
of commands.\n", argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	exit(EXIT_SUCCESS);
 }


	
	
		
______________________________________________ 
LLama Gratis a cualquier PC del Mundo. 
Llamadas a fijos y móviles desde 1 céntimo por minuto. 
http://es.voice.yahoo.com



--===============0827358740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0827358740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0827358740==--
