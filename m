Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Qualification Testing
From: Stephen Crane <steve.crane@rococosoft.com>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000c01c313f5$b57ae030$1a01010a@baked>
References: <000c01c313f5$b57ae030$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1052304997.1379.535.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 07 May 2003 11:56:38 +0100

Hi Daryl,

On Tue, 2003-05-06 at 18:34, Daryl Van Vorst wrote:
> Qualification failures/problems: (I can get tester logs for most of these
> failures if they would be helpful.)
> 
> SDP:
>         PASS! (for our purposes), but there were a few things of note:
>         1.) The SDP entry for the SDP server itself should have a Language
> Base Attribute ID List (because there are text descriptions). I'm not
> absolutely clear on whether or not it is mandatory, but it would make the
> testers happy. Can an application add an attribute to that record, or would
> sdpd have to be modified?

Should be fixed in CVS for sdpd. (However, I can't find out how the ISO
639 language name, e.g., 'en', is mapped to a UINT_16. I assumed 'e' is
more significant.)

>         2.) There appears to be a problem handling continuation states.
> Handling continuation state is optional. We found that if the querying
> device sends a maximum byte count of 100, the continutation state worked
> fine. But if the querying device sent a maximum byte count of 8, the
> continuation state doesn't work (the continuation flag wasn't recognized in
> the next packet). I can dig up an example log if it would help.

Yeah it would be good to get a log. I imagine 8-bytes is pretty close to
the minimum size.

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
