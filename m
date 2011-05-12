Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth: l2cap and rfcomm: fix 1 byte infoleak to userspace.
From: Marcel Holtmann <marcel@holtmann.org>
To: Filip Palian <s3810@pjwstk.edu.pl>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20110512173246.GC11166@backtrack>
References: <BANLkTik7WyQ977-+8XapTgBrVRMyexyHKg@mail.gmail.com>
	 <1305163800.15916.169.camel@aeonflux>  <20110512173246.GC11166@backtrack>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 May 2011 12:08:43 -0700
Message-ID: <1305227323.15916.174.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Filip,

> Structures "l2cap_conninfo" and "rfcomm_conninfo" have one padding
> byte each. This byte in "cinfo" is copied to userspace uninitialized.
> 
> Signed-off-by: Filip Palian <filip.palian@pjwstk.edu.pl>

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


