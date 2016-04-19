Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 19 Apr 2016 20:25:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fran=E7ois?= Beaufort <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Add Eddystone GATT Config Service to known UUIDs
Message-ID: <20160419172500.GA16645@t440s.P-661HNU-F1>
References: <CAEZxfGMCA_A1RQVmxr6DWgweD5Qg6e34F-09Ws=stLpV=YU5=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAEZxfGMCA_A1RQVmxr6DWgweD5Qg6e34F-09Ws=stLpV=YU5=w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Tue, Apr 19, 2016, François Beaufort wrote:
> I'd love to see the new Eddystone Configuration GATT Service
> (https://github.com/google/eddystone/tree/master/configuration-service)
> being recognized by BlueZ.
> Could you guys make this happen?

That'd indeed be nice! I'm not volunteering, but I do have a question
about this part:

"Where not explicitly stated, data written and read is defined in terms
of big-endian arrays of signed bytes."

Why on earth big-endian? GATT, like most other Bluetooth protocols, is
little-endian. Can this still be fixed?

Johan
