Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 11:42:02 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 15/16] android: Implement basic HAL server
Message-ID: <20130930084123.GG10262@aemeltch-MOBL1>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1380291161-10232-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20130929145947.GA28937@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130929145947.GA28937@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sun, Sep 29, 2013 at 05:59:47PM +0300, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Fri, Sep 27, 2013, Andrei Emeltchenko wrote:
> > +	sock = socket(AF_UNIX, SOCK_STREAM, 0);
> > +	if (sock < 0) {
> > +		error("%s: socket(): %s", __func__, strerror(errno));
> > +		return sock;
> > +	}
> 
> This should be SOCK_SEQPACKET. It has been mentioned several times in
> our (offline) conversations and is also clearly stated in the IPC
> document we'll soon push upstream.
> 
> > +	/* Since daemon would be run also on host we have to grant perms */
> > +	chmod(sock_path, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH |
> > +								S_IWOTH);
> 
> Is this really necessary? On the host (by which I presume you mean the
> system where you build BlueZ, i.e. a non-android system) couldn't the
> test tool that's used just exec the daemon and then you have the same
> context for both processes that need to access the socket.

We need to set userid for the daemon in Android to "bluetooth" and my patch
with this change cannot compile for the host as it was mentioned in the
review. So I will use #ifdef to separate Android and host.

> 
> > @@ -646,11 +648,13 @@ int main(int argc, char *argv[])
> >  		exit(1);
> >  
> >  	init_mgmt_interface();
> > +	start_hal_srv("/dev/socket/bluez_hal");
> 
> Isn't /var/run the right place for stuff like this? Alternatively we
> could also go with an abstract socket and then not care about any
> associations with the file system at all.

Android sockets should go to the standard Android sockets place, for the
host this can be any of your choice. /var/run ?

I will separate them by ifdef logic

Best regards 
Andrei Emeltchenko 

