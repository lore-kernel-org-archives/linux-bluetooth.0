Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Aug 2010 11:50:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alexander Orlenko <zxteam@gmail.com>,
	Lorenzo Brito Morales <lorenzo.brito@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: its possible to make a streaming video whith bluez?
Message-ID: <20100819085006.GA7740@jh-x301>
References: <AANLkTikEHVwEXQg=0ahqwDOANa-VPLjd11xC2ri2N8d5@mail.gmail.com>
 <20100819074920.GA5401@jh-x301>
 <AANLkTindRBGJtWuE8OX+fAEAQOSQHzEgLdGdUUHfOKKT@mail.gmail.com>
 <20100819083323.GA7327@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100819083323.GA7327@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 19, 2010, Johan Hedberg wrote:
> On Thu, Aug 19, 2010, Alexander Orlenko wrote:
> > > Do you have plans to implement this for BlueZ?
> > It's a GSoC'10 project. http://hostisdown.org/gsoc/projects/vdp
> 
> Ha. Seems I've missed that one completely (though not really a surprise
> since there doesn't seem to have been any communication about it here on
> the mailing list).

I just just took a peek at the projects git tree. There's essentially
nothing there besides some very simple stub files. Also, there doesn't
seem to be anything AVDTP related in the tree but just raw data (video)
sending over an L2CAP connection. So if that's all that there is then
the statement "nothing exists for VDP in BlueZ right now" is actually
quite close to the truth.

Johan
