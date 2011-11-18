Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Nov 2011 13:15:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Health Thermometer Profile (HTP)
Message-ID: <20111118111529.GA2586@x220>
References: <1321272680-16286-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321272680-16286-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Mon, Nov 14, 2011, Santiago Carot-Nemesio wrote:
> This is a new set of patches to enhance thermometer plugin fuctionality.
> These patches enable watchers to receiave final/intermediate measurements
> from thermometers devices. They also includes latest changes suggested
> in the list.
> 
> [PATCH 1/6] Manage GATT attribute indications in handle callback.
> [PATCH 2/6] Parse final measurement indication
> [PATCH 3/6] Add org.bluez.ThermometerWatcher interface to default
> [PATCH 4/6] Implement EnableIntermediateMeasurement D-Bus method
> [PATCH 5/6] Implement DisableIntermediateMeasurement D-Bus method
> [PATCH 6/6] Notify intermediate measurements

All of these patches have been pushed upstream. Thanks.

Johan
