Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: Question about HCI_QUIRK_RESET_ON_CLOSE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140609181441.GA30978@t440s.P-661HNU-F1>
Date: Mon, 9 Jun 2014 20:19:12 +0200
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <841D802D-B6E2-4C4B-81C9-6AC2730FBA94@holtmann.org>
References: <20140609083124.1ea9e852@han1-desk-dev> <8BACFBA7-C6B6-4BE7-9107-2E4665B3A278@holtmann.org> <20140609101542.5b7ae24a@han1-desk-dev> <98D1490C-B3DC-4CEC-971B-F24F515CFC2E@holtmann.org> <20140609181441.GA30978@t440s.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> I think that 3.14 kernel and later have this feature enabled. What I
>> can tell is that we cancel connection attempts since I found a follow
>> up patch there. For inquiry and remote name request, I do not know.
>> 
>> Johan, did we ever checked this and in addition that we send a
>> Discovery Stopped event as well.
> 
> I'm not completely sure about a proper emission of Discover Stopped, but
> the function to look at is clean_up_hci_state() in mgmt.c. You'll see
> that it stops inquiry scan & page scan, advertising, LE scanning,
> cancels outgoing connection attempts and disconnects existing
> connections.
> 
> However, as I just looked at the function we seem to (quite
> surprisingly) have completely forgotten about inquiry (either normal or
> periodic), so another patch to this function is needed as it seems.

the same might apply to remote name request that we also have to cancel. However we might should just run a normal stop discovery procedure. Since that should already today clear this all correctly.

Regards

Marcel

