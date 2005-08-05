Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Possible security vulnerability in hcid when
	calling pin helper
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050805063927.3d714a89.henryk@ploetzli.ch>
References: <20050805050932.3111586d.henryk@ploetzli.ch>
	 <1123211794.8331.104.camel@pegasus>
	 <20050805063927.3d714a89.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1123231158.8331.109.camel@pegasus>
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
Date: Fri, 05 Aug 2005 10:39:18 +0200

Hi Henryk,

> > thanks for catching this problem. Do you have a fix for it?
> 
> Now I have, I think. Doing string escaping in C is really awkward, but
> this patch should prefix all occurences of ", \, $ or ` in the name with
> an \, and will also change the enclosing single quotes to double quotes
> (because no escaping is possible in single quotes). There would also be
> an alternative way to fix it: remove the popen() and instead do a
> pipe()/fork()/dup2()/execv() combination. That should be more clean, but
> likely more complicated.

the final patch looks a little bit different, but it is now fixed in the
CVS tree. Thanks.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
