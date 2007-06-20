Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c1fa8edf0706191743w6e2caad3p428bef72598b8878@mail.gmail.com>
Date: Tue, 19 Jun 2007 20:43:22 -0400
From: Simon <simon80@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200706180938.10993.fernando@bluexare.org>
MIME-Version: 1.0
References: <200706151809.04115.fernando@bluexare.org>
	<1181978987.6846.50.camel@aeonflux.inter-touch.com>
	<200706180938.10993.fernando@bluexare.org>
Subject: Re: [Bluez-devel] Problems with my own inquiry
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

On 6/18/07, Fernando Unzu <fernando@bluexare.org> wrote:
> When I install the new distribution, I update the bluetooth/bluez packages
> with "apt-get", so there may be the later version, doesn't do?
> If it is not true, where I can update my version to one make my system works
> ok?

I think that what Marcel meant was that you should change your
application code to communicate with bluez using D-Bus instead of
library calls.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
