Return-Path: <dzickus@redhat.com>
Date: Mon, 11 Apr 2016 10:15:30 -0400
From: Don Zickus <dzickus@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: How stable is the blueoothd -E support?
Message-ID: <20160411141530.GO91959@redhat.com>
References: <20160401202525.GZ159470@redhat.com>
 <49DDCCFA-5619-4DC0-9488-FA4C52F217DF@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49DDCCFA-5619-4DC0-9488-FA4C52F217DF@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 08, 2016 at 10:07:51AM -0700, Marcel Holtmann wrote:
> Hi Don,
> 
> > I was wondering how stable the experimental interface was, namely the GATT
> > stuff.  I was thinking about convincing the Fedora folks to set it so folks
> > can build off of the API.  As that is the only way it seems to communicate
> > with my LE devices.
> 
> it should be rather stable actually. However there were some comments lately and we need to look into them. My goal was actually to remove the experimental flag for the GATT APIs in one of the next releases.

Great!  I assume you have no intentions to change the API anymore, but that
would depend on the outcome of your investigation of said comments?

Do you think you will have that resolved after 2 months?  Trying to do some
planning.  No worries if you can't commit, just asking. :-)

Cheers,
Don
