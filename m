Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 11:23:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Reorganizing the BlueZ source tree
Message-ID: <20120524082352.GA20516@x220>
References: <20120524081405.GA30941@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120524081405.GA30941@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 24, 2012, Gustavo Padovan wrote:
> lib             -> profiles

Was this a typo? I'd have suggested to rename the existing "lib" to the
new "libs" and after that start moving the other "lib" subdirectories
there. The existing content of lib might also be reorganized, e.g. move
SDP code into libs/sdp/

Johan
