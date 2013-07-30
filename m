Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Jul 2013 14:28:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Subject: Re: [PATCH 1/3] Update gatt_service_add size assert for dealing with
 128-bit uuids
Message-ID: <20130730112818.GC12745@x220.p-661hnu-f1>
References: <1375123370-20055-1-git-send-email-djcb.bulk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375123370-20055-1-git-send-email-djcb.bulk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dirk,

On Mon, Jul 29, 2013, Dirk-Jan C. Binnema wrote:
> To paraphrase Anderson Lizardo: "h" was overflowing for 128-bit services
> because the handle is incremented after each attribute is added so at the
> end we had: 0xffff + 1 == 0 (h is uint16_t).
> 
> As it seems more complex to try to remove the overflow without
> affecting the logic too much, we update the assertion.
> ---
>  attrib/gatt-service.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I made a couple of more cosmetic cleanups and after that pushed these
patches upstream. Thanks.

Some things to keep in mind for future patches:

- Keep your commit message line lengths max 72-74 (both git log and git
  shortlog indent them and we don't want to run past a 80 char terminal)
- Prefix the summary lines appropriately (in this case "attrib: ...")
- Split lines are indented as much as possible while keeping them under
  80 characters (i.e. not just past the opening parenthesis)

Johan
