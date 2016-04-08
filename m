Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How stable is the blueoothd -E support?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160401202525.GZ159470@redhat.com>
Date: Fri, 8 Apr 2016 10:07:51 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Message-Id: <49DDCCFA-5619-4DC0-9488-FA4C52F217DF@holtmann.org>
References: <20160401202525.GZ159470@redhat.com>
To: Don Zickus <dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Don,

> I was wondering how stable the experimental interface was, namely the GATT
> stuff.  I was thinking about convincing the Fedora folks to set it so folks
> can build off of the API.  As that is the only way it seems to communicate
> with my LE devices.

it should be rather stable actually. However there were some comments lately and we need to look into them. My goal was actually to remove the experimental flag for the GATT APIs in one of the next releases.

Regards

Marcel

