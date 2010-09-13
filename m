Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Sep 2010 13:59:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [RFC] BlueZ D-Bus Sim Access Profile Server API description
Message-ID: <20100913105932.GA3566@jh-x301>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284374584-12282-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

On Mon, Sep 13, 2010, Suraj Sumangala wrote:
> +		void Response(string command, string result, object response)

This method should be removed. Instead, you should use the methor return
messages for the commands to relay the response information.

> +Sim Access Server Agent hierarchy
> +=================================
> +
> +Service         unique name
> +Interface       org.bluez.SAPServerAgent
> +Object path     freely definable
> +
> +Methods		Request(string command, object param)

Since the set of SAP commands is fixed and rather short it'd be much
simpler if you have a separate D-Bus method for each command
(particularly from the method and method return signature perspective).
You also seem to have some confusion about what an "object" type
parameter is. It seems you're using it for some sort of variant type
when it will only ever represent a simple object path.

Johan
