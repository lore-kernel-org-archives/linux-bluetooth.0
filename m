Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] Move adapter config file to ini-file format
Date: Wed, 10 Oct 2012 15:01:40 +0200
Message-ID: <3043065.CnC5bYlbBs@uw000953>
In-Reply-To: <CAJdJm_OCcpXD7oPMQec-Z_UdhF7tfEOCs47Zfrq6+JQVrga2mQ@mail.gmail.com>
References: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com> <1349863391.27233.115.camel@aeonflux> <CAJdJm_OCcpXD7oPMQec-Z_UdhF7tfEOCs47Zfrq6+JQVrga2mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wednesday 10 of October 2012 13:37:33 Anderson Lizardo wrote:
> Hi Marcel,
> 
> On Wed, Oct 10, 2012 at 6:03 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > For the actual change to the new format, can you first create a document
> > describing the new format. Something like doc/settings-storage.txt or
> > similar (if anyone can think of a better name).
> 
> Would be interesting to update ./src/bluetoothd.8.in as well, or
> simply drop the description for config storage files?

I don't think man page should contain such information as description of data
stored by bluetoothd. This is a private daemon data that is not suppose to
be modified by hand.

Instead, it should contain comprehensive information about configuration files
located in /etc/bluetooth and note about location and purpose of data files.
(opposite to what is now in bluetoothd manual..)

By comprehensive I mean not necessarily full description of every option
possible (this could be located in separate manual or in example config files
as it is now) but clear description of what each file is responsible for, when
and how it is parsed etc.

-- 
BR
Szymon Janc
