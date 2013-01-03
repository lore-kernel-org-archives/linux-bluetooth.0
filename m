Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jan 2013 19:16:54 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>,
	Michael Knudsen <michaelknudsendk@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Michael Knudsen <m.knudsen@samsung.com>
Subject: Re: [RFC 3/3] Bluetooth:  Provide mgmt API for reading list of
 supported codecs
Message-ID: <20130103221654.GA11342@samus>
References: <1353585909-28400-1-git-send-email-m.knudsen@samsung.com>
 <1353585909-28400-4-git-send-email-m.knudsen@samsung.com>
 <20130103190916.GA2114@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130103190916.GA2114@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> 
> We think it is better to read the list of codecs from the SCO socket, we need
> to allow both oFono and PulseAudio to read them without the need of talking to
> BlueZ. Also, bluetoothd has nothing intersting to do with this information.

Take a look at the thread "CSA2: User space aspect"[1]. I have to agree
with Marcel, the mgmt command makes more sense. As how that information
will get to oFono/PulseAudio we have NewConnection() in the Profile API
and SetConfiguration() on the Media API, that may be extended (if
needed).

> 
> 	Gustavo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius

[1] http://thread.gmane.org/gmane.linux.bluez.kernel/31746
