Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710301323h5a56b932h8304f42f5ae3fc6@mail.gmail.com>
Date: Tue, 30 Oct 2007 14:23:39 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <307f591f0710301305n410b8ebds4fa399dd0a518840@mail.gmail.com>
MIME-Version: 1.0
References: <307f591f0710301305n410b8ebds4fa399dd0a518840@mail.gmail.com>
Subject: Re: [Bluez-devel] multi-frequency scanning & possible contract work
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

Paul

Are you using hcitool from the command line? Use the D-Bus bindings
(eg python) with a listener method for discovered devices and you'll
get piecemeal results that are likely more timely. Maybe look into
extended inquiry too.

On 10/30/07, Paul Huber <paul2004x@gmail.com> wrote:
> I need to use a directional antenna focused on an area about 6 meters x 6
> meters that can scan for Bluetooth mobile phones as they pass through the
> area, and identify them very quickly.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
