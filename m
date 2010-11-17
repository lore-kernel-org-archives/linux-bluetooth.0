Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Nov 2010 21:01:03 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Automate remote name requests
Message-ID: <20101117230103.GA32261@vigoh>
References: <1289401913-22982-1-git-send-email-johan.hedberg@gmail.com>
 <1289401913-22982-3-git-send-email-johan.hedberg@gmail.com>
 <20101116220907.GA30115@vigoh>
 <20101117223057.GB20735@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101117223057.GB20735@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Johan Hedberg <johan.hedberg@gmail.com> [2010-11-18 00:30:57 +0200]:

> Hi Gustavo,
> 
> On Tue, Nov 16, 2010, Gustavo F. Padovan wrote:
> > > -static int request_outgoing_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
> > > +static int outgoing_auth_needed(struct hci_dev *hdev, bdaddr_t *bdaddr)
> > 
> > Can you add a hci_ in the beginning of your functions, just to keep the
> > coherency with the rest of the code.
> 
> Sure. I guess I'm too used to the userspace convention where strict
> namespacing is only used for exported (non-static) functions.
> 
> > I'm not happy with have to lookup the hci_conn twice when we can do that
> > once here. I've noted that always outgoing_auth_needed() returns 1 you do
> > a request_auth, and always it returns 0 you don't, so I think we can
> > embed request_auth() inside outgoing_auth_needed() as it was in patch
> > 2/3 and the give a better name to outgoing_auth_needed() which you
> > reflect the new behavior.
> 
> I don't think the check and request should be in the same function since
> there are two places that need the check but not the request.

In that case such function will return after the check not doing any
request.

-- 
Gustavo F. Padovan
http://profusion.mobi
