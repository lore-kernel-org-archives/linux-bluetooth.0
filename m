Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Sep 2014 16:32:35 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix for sdp-client in reconnect scenario
Message-ID: <20140909233235.GA21249@t440s>
References: <1410253330-27768-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410253330-27768-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, Sep 09, 2014, Lukasz Rymanowski wrote:
> This patch fixes following error scenario:
> 1. Local device does sdp search and cache sdp session.
> 2. Peer device disconnect and connect again
> 3. Local device wants to do sdp search again on outdated sdp session
> 
> If those 3 steps will happen withing 2 sec, we face the issue.
> 
> Those patch fixes that.
> Automated test which easly triggers that will come from Jakub.
> (Hid Host reconnect test)
> 
> Lukasz Rymanowski (3):
>   sdp-client: Extract cleanup function for cached session
>   sdp-client: Add disconnect watch for cached session
>   sdp-client: Minor code style fix
> 
>  src/sdp-client.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)

All three patches have been applied. Thanks.

Johan
