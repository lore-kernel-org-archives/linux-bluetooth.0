Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] scooped by pocketpc (a2dp)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41EA1B6E.3070303@xmission.com>
References: <41E93682.9040907@xmission.com>
	 <41E93B4F.1010600@dark-reality.de>  <41EA1B6E.3070303@xmission.com>
Content-Type: text/plain
Message-Id: <1106569928.9269.78.camel@pegasus>
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
Date: Mon, 24 Jan 2005 13:32:08 +0100

Hi Brad,

> > writing the a2dp alsa driver should be similar to the btsco alsa part,
> > maybe we can build one thing for both purposes, or at least keep
> > structures similar so that both projects can support each other best!
> 
> well i want to try putting a2dp in a userspace driver since that might 
> be the best way to go. (that's an issue that may not be totally worked 
> out but i think we decided that it looks attractive enough to at least 
> try writing alsa-lib drivers)
> 
> if it works well, we might rewrite the sco driver to be in userspace.

I like to see both drivers in userspace as an ALSA library plugin. The
SCO driver is somewhat more interesting at the moment, because of the
ongoing VoIP hype.

There is also an SDK for ALSA library plugins planned that should make
this development easier and possible to develop them outside the ALSA
source code.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
