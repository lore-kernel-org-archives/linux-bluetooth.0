Return-Path: <cyrus@holtmann.org>
Date: Sun, 12 Sep 2010 11:44:11 +0300
From: Ivan Baidakou <the.dmol@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: dund
Message-ID: <20100912114411.2678ffbe@gmail.com>
In-Reply-To: <16C0AC8E-F3CC-41A8-BE7D-C1BCB7F10CCC@hadess.net>
References: <20100911214553.0d8bc6f0@gmail.com>
	<16C0AC8E-F3CC-41A8-BE7D-C1BCB7F10CCC@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---=== reply ===---

You haven't real experience, right? In any case I don't know how to do
it: in the official pilot-link guide there is need to establish TCP
connection to sync (http://howto.pilot-link.org/bluesync/gb.html), and
to establish it they recommend to launch dund
(http://howto.pilot-link.org/bluesync/ga.html). 

That's why I do ask here, what thing in new bluez can replace the 
deprecated dund?

Best regards,
Ivan Baidakou

---=== original message ===---
Date: Sun, 12 Sep 2010 00:26:57 +0100
Subj: Re: dund
From: Bastien Nocera <hadess@hadess.net>
To: Ivan Baidakou <the.dmol@gmail.com>


On 11 Sep 2010, at 19:45, Ivan Baidakou <the.dmol@gmail.com> wrote:

> Hi All,
> 
> There was DUN daemon in bluez 2.x, but in current version it moved to
> old daemons and considered deprecated. If I understand correctly its
> aim is simple to launch pppd on incoming connection.
> 
> Is is possible to reach the same behaviour via current implementation
> without dund? Currently I do need dund to sync my Palm with desktop; I
> performed internet search and found not any solution. 

Gnome-pilot and pilot-link both support native Bluetooth connections.
 
Cheers

