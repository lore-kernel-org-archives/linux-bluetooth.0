Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@iki.fi>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050123113924.GA17069@salvia.homeip.net>
References: <20050119224400.GA7881@salvia.homeip.net> <1106180379.8190.146.camel@pegasus> <20050120003408.GA8619@salvia.homeip.net> <1106182874.8190.166.camel@pegasus> <20050120090340.GA9719@salvia.homeip.net> <1106470008.8112.9.camel@pegasus>
Mime-Version: 1.0
In-Reply-To: <1106470008.8112.9.camel@pegasus>
Subject: Re: [Bluez-devel] [PATCH] Fix too-many-keys-pressed error in hidp/core.c
Content-Type: text/plain; charset=us-ascii
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
Date: Sun, 23 Jan 2005 13:39:24 +0200

Hi Marcel,

On Sun, Jan 23, 2005 at 09:46:48AM +0100, Marcel Holtmann wrote:

> I think we should add a patch for this, but I don't like the way you did
> it. Checking for the end value of a for-loop is not a good programming
> practice. Using memcmp() here should be a lot better and cleaner.

It depends on how you think about the problem.  If you see the data as just
an array of bytes, memcmp() is the way to go.  If you think of it as 6
consecutive key codes, with each one set to 1, for loop is conceptually the            
right thing to use.
        
Cheers,
Juha


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
