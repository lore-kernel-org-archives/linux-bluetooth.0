Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v6 3/6] Add support for Out of Band (OOB) association model in hciops
Date: Sat, 26 Mar 2011 12:26:08 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
References: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com> <1300974459-24076-4-git-send-email-szymon.janc@tieto.com> <20110325083350.GC30796@jh-x301>
In-Reply-To: <20110325083350.GC30796@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201103261226.08475.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Szymon,

Hi,

> > +		data = g_new(struct oob_data, 1);
> > +		bacpy(&data->bdaddr, bdaddr);
> > +		dev->oob_data = g_slist_prepend(dev->oob_data, data);
> 
> Probably g_new0 would be better here (doesn't oob_data have more members
> than just the bdaddr?

Other members (hash and randomizer) are written right after that if-else.

	if (match) {
		data = match->data;
	} else {
		data = g_new(struct oob_data, 1);
		bacpy(&data->bdaddr, bdaddr);
		dev->oob_data = g_slist_prepend(dev->oob_data, data);
	}

	memcpy(data->hash, hash, sizeof(data->hash));
	memcpy(data->randomizer, randomizer, sizeof(data->randomizer));

So there is no need for zeroing data on allocation.

-- 
BR
Szymon Janc
