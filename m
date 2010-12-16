Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 11:29:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] add btd_error_agent_not_assigned()
Message-ID: <20101216092946.GD4322@jh-x301>
References: <1292450823-17640-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292450823-17640-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Dec 15, 2010, Gustavo F. Padovan wrote:
> +DBusMessage *btd_error_agent_not_assigned(DBusMessage *msg)
> +{
> +	return g_dbus_create_error(msg, ERROR_INTERFACE ".AgentNotAssigned",
> +					"Agent Not Assigned");
> +}
> +

Could we make this AgentNotAvailable instead?

Johan
