Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2013 15:45:53 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/6 v2] media-api: Add org.bluez.MediaFolder1
Message-ID: <20130201214553.GA4352@x220.aaadfw.dal.wayport.net>
References: <1359754105-8185-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359754105-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 01, 2013, Luiz Augusto von Dentz wrote:
> This interface adds support for browsing and searching in the player's
> storage using AVRCP 1.4/1.5.
> 
> Some remarks about the design:
> 
>   - Exposing UIDCounter and UIDs was considered, but the spec seems to have
>     missed to define the player's id persistency. There are also the fact that
>     UIDCounter alone does not guarantee persistency across sessions and do not
>     provide what exact items have changed, so in the end exposing these
>     details will bring almost no value.
>   - Indexing or caching the whole media library is not recommended, Bluetooth
>     is too slow for that and even vendors such as Apple do not recommend doing
>     it, so the only items keep in cache are the current listed ones.
>   - Addressed vs Browsed player is done implicitly when accessed, this was done
>     to simplify the API and avoid confusions between applications and players.
> ---
> v2: Remove Buttons property for now
> 
>  doc/media-api.txt | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 171 insertions(+)

All patches in this set have been applied. Thanks.

Johan
