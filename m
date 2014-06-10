Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jun 2014 14:36:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Subject: Re: Question about HCI_QUIRK_RESET_ON_CLOSE
Message-ID: <20140610113607.GA2940@t440s.lan>
References: <20140609083124.1ea9e852@han1-desk-dev>
 <8BACFBA7-C6B6-4BE7-9107-2E4665B3A278@holtmann.org>
 <20140609101542.5b7ae24a@han1-desk-dev>
 <98D1490C-B3DC-4CEC-971B-F24F515CFC2E@holtmann.org>
 <20140609122130.5f43d7e2@han1-desk-dev>
 <CABBYNZ+SYw8isMGSs=1i6CEt+c1nZ3R6PHy9VAgRfRSkYULfcQ@mail.gmail.com>
 <08DDD269-D7D4-4A3F-A5A0-EECF0A30B188@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08DDD269-D7D4-4A3F-A5A0-EECF0A30B188@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jun 10, 2014, Marcel Holtmann wrote:
> The real fix here is that we cancel inquiry and remote name request
> operations that occupy the baseband and will cause HCI event along the
> line later on. We could also set the HCI event mask(s) to zero.

I've just sent three patches that cover the inquiry and name request
parts.

Johan
