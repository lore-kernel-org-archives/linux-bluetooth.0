Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Oct 2010 18:09:54 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Fix problem with operator name length
Message-ID: <20101013150954.GA7208@jh-x301>
References: <1286974170-12282-1-git-send-email-lucas.pawlik@gmail.com>
 <20101013141921.GB4828@jh-x301>
 <1286981571.2142.5.camel@dp-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286981571.2142.5.camel@dp-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

First of all, don't top-post on this list.

On Wed, Oct 13, 2010, Dmitriy Paliy wrote:
> At the moment it is received in ascii from csd since not all car kits
> can handle utf8.

Ok, in that case it should be safe. I went ahead and and pushed the
patch along with a clarification in the commit message about this
guarantee that the csd API gives.

Johan

