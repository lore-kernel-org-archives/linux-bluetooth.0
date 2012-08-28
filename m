Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NL5ALYLKcHJ7uzWdtgkC_72++58GWm=CRXea_YEaYcqg@mail.gmail.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
	<1344870497-6929-2-git-send-email-rafal.garbat@tieto.com>
	<20120814095636.GA7055@x220>
	<20120828152058.GA18913@x220.sheraton.com>
	<503CE72D.2030501@tieto.com>
	<20120828165650.GA3165@x220.sheraton.com>
	<CAJdJm_PWn--HEsaex1zqL_CqEBvjKQXSABBnPeYP9CVKgeA6Wg@mail.gmail.com>
	<20120828181041.GA7686@x220.sheraton.com>
	<CAJdJm_NL5ALYLKcHJ7uzWdtgkC_72++58GWm=CRXea_YEaYcqg@mail.gmail.com>
Date: Tue, 28 Aug 2012 15:21:01 -0400
Message-ID: <CAJdJm_NTTyaKhmgnYJc40xpPLTRwAJ9EkLKCH67nmMJU8KvE+w@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] Heart Rate Profile API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Garbat Rafal <rafal.garbat@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	Santiago Carot-Nemesio <sancane@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

After some discussion with Johan on IRC, I think I understand what he
is proposing, and it makes sense IMHO. The idea is to simply replace
the object path for RegisterWatcher/UnregisterWatcher to [variable
prefix]/{hci0,hci1,...} (adapter path) and have the watcher object
methods accept a "object device" as first argument.

This way, the application that wants to register wacthers will monitor
only for new adapters (and not new devices) and register watchers on
them. The D-Bus interface for RegisterWatcher() will still be profile
specific (e.g. org.bluez.HeartRate in this case).

One issue with this idea (and which still needs to be sorted out if we
proceed with this), is that other methods specific to the profile
(like Reset() for Heart Rate and EnableIntermediateMeasurement() for
Thermometer) need to be in different interfaces.

Johan, do you have any ideas for this?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
