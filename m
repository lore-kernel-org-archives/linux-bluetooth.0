Return-Path: <cyrus@holtmann.org>
Message-ID: <4CF3ABD4.6080809@openbossa.org>
Date: Mon, 29 Nov 2010 08:34:12 -0500
From: Sheldon Demario <sheldon.demario@openbossa.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Emit Connect signal for LE capable devices
References: <1290705769-15487-1-git-send-email-sheldon.demario@openbossa.org> <20101129125208.GA15399@jh-x301>
In-Reply-To: <20101129125208.GA15399@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 11/29/2010 07:52 AM, Johan Hedberg wrote:
> Hi Sheldon,
>
> On Thu, Nov 25, 2010, Sheldon Demario wrote:
>> +	if (le) {
>> +		evt_le_connection_complete *evt = ptr;
>> +		evt_bdaddr =&evt->peer_bdaddr;
>> +		evt_handle = evt->handle;
>> +		evt_status = evt->status;
>> +	}  else {
>> +		evt_conn_complete *evt = ptr;
>> +		evt_bdaddr =&evt->bdaddr;
>> +		evt_handle = evt->handle;
>> +		evt_status = evt->status;
>> +
>> +		if (evt->link_type != ACL_LINK)
>> +			return;
>> +	}
> Instead of this kind of trickery, I have a feeling that the code would
> be easier to read if you had a separate function for the LE connect
> complete. Could try try to come up with a patch that does it like that?

For sure, but don't you think that doing this way there will be a lot of 
duplicated code?

Sheldon.
