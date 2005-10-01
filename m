Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05093011224be94d05@mail.gmail.com>
References: <e1effdeb05093011224be94d05@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128160192.8555.6.camel@localhost.localdomain>
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
Date: Sat, 01 Oct 2005 11:49:52 +0200

Hi Claudio,

> The patch is attached. The basic structure to start the development of
> the "sdp", "network", "serial", ... was added. 
> There are a lot not implemented methods.

this patch looks like this:

 common/Makefile.am   |    4
 common/util.c        |   80 ++++
 common/util.h        |   35 +
 hcid/dbus-internal.h |   82 ++++
 hcid/dbus.c          |  909 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 hcid/dbus.h          |  200 +++++++++++
 hcid/hcid.h          |    1
 hcid/main.c          |   17
 tools/Makefile.am    |    2
 tools/hcitool.c      |   27 -
 10 files changed, 1319 insertions(+), 38 deletions(-)

It is changing everything and looks like a previous patch that I
reviewed.

I don't wanna see any changes outside hcid/dbus.[ch] at the moment and
the error definitions we agreed on are not included. It seems you just
modified one of your older patches with the new objects and paths. I
want to include something before the next release, but I am going the
full patch at the moment.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
