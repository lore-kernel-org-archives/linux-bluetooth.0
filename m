Return-Path: <cyrus@holtmann.org>
Message-Id: <1360616964.13178.140661190029021.00F49EEA@webmail.messagingengine.com>
From: Rebecca Menessec <rebecca.menessec@ironhavoc.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain
Reply-To: rebecca.menessec@ironhavoc.org
In-Reply-To: <20130211193754.GA12283@x220.P-661HNU-F1>
References: <1360448522.23439.140661189177761.7087C9E4@webmail.messagingengine.com>
 <20130211193754.GA12283@x220.P-661HNU-F1>
Subject: Re: Missing manpage for main.conf
Date: Mon, 11 Feb 2013 16:09:24 -0500
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the update. I'll ask rsyslog to send bluetoothd output to
/dev/null until / unless I need it, then. :)

I've been trying to turn off all unnecessary logging on a
resource-constrained system so as to avoid wasting the CPU cycles and
wake-ups.

On 2013-02-11 21:37:54 (+0200), Johan Hedberg wrote:
> Hi Rebecca,
> 
> On Sat, Feb 09, 2013, Rebecca Menessec wrote:
> > I was looking for a way to disable BlueZ logging (Ubuntu machine), and
> > came across this, in the bluetoothd manpage:
> > 
> > 'bluetoothd itself does not accept many command-line options, as most of
> > its configuration is done in the /etc/bluetooth/main.conf file, which
> > has its own man page.'
> > 
> > That doesn't appear to be true. I can't find any trace in any distro, or
> > in the source. I've found a bug filed here and there against the lack of
> > manpage, but no manpage.
> 
> This is indeed a bug. I just pushed a patch to remove this reference
> from the bluetoothd man page. main.conf might deserve its own man page
> (even though the upstream sample is self-documenting) but as long one
> doesn't exist it's at least better not to have a bogus reference to it.
> 
> It's also worth noting that we're really trying to promote systems
> without any /etc/bluetooth directory at all since the bluetoothd
> defaults should be usable by as many as possible.
> 
> > There's definitely logging going on by default:
> > 
> > localhost ~ [0]# lsof -n 2> /dev/null | grep blue | grep log
> > rsyslogd   804          syslog    2w      REG               0,21    
> > 2027       8482 /var/log/bluetoothd.log
> > rs:main    804  813     syslog    2w      REG               0,21    
> > 2027       8482 /var/log/bluetoothd.log
> > rsyslogd   804  814     syslog    2w      REG               0,21    
> > 2027       8482 /var/log/bluetoothd.log
> > rsyslogd   804  815     syslog    2w      REG               0,21    
> > 2027       8482 /var/log/bluetoothd.log
> > 
> > Unfortunately, there's no hint anywhere what's causing bluetoothd to
> > log, or how to stop it.
> 
> There is no way to stop bluetoothd from logging errors. You can
> enable/disable debug logs with the -d switch but that's it.
> 
> Johan
