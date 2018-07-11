Return-Path: <ianwmorrison@gmail.com>
MIME-Version: 1.0
References: <20180710081117.25078-1-hdegoede@redhat.com>
In-Reply-To: <20180710081117.25078-1-hdegoede@redhat.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Wed, 11 Jul 2018 11:24:22 +1000
Message-ID: <CAFXWsS8DLDpK1TmsFfeGZPH1xJGksVGRHbbp+b3sfkruwAZ6CQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Bluetooth: Add RTL8723BS support
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jeremy Cline <jeremy@jcline.org>,
	"bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 10 Jul 2018 at 18:12, Hans de Goede <hdegoede@redhat.com> wrote:
>
>
> New in v3:
> -Fix build error when CONFIG_RTL_BT is not set, reported by Paul Cercueil
>
Hi Hans,

Minor point but v3 fix is for CONFIG_BT_RTL.

Regards,
Ian
