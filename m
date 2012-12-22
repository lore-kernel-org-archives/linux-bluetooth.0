Return-Path: <cyrus@holtmann.org>
Date: Sat, 22 Dec 2012 18:51:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/4] hog: Remove pre-existing suspend FIFO
Message-ID: <20121222165123.GA25832@x220.P-661HNU-F1>
References: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
 <1356189162-11584-4-git-send-email-jprvita@openbossa.org>
 <1356194171.29264.14.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356194171.29264.14.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Dec 22, 2012, Marcel Holtmann wrote:
> > +			if (remove(HOG_SUSPEND_FIFO) < 0) {
> 
> you are looking for unlink() to use here.

Since I already applied the patches I went ahead and fixed this myself.

Johan
