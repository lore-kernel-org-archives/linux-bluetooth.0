Return-Path: <cyrus@holtmann.org>
Message-ID: <4FE1CB70.3050801@linux.intel.com>
Date: Wed, 20 Jun 2012 15:09:04 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sdp: Prevent duplicate records registration
References: <1340182921-12448-1-git-send-email-frederic.danis@linux.intel.com> <20120620093513.GA17683@x220>
In-Reply-To: <20120620093513.GA17683@x220>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

On 20/06/2012 11:35, Johan Hedberg wrote:
> Hi Frédéric,
>
> On Wed, Jun 20, 2012, Frédéric Danis wrote:
>> Check if a record with same UUID and protocol descriptor already exists
>> before adding new record to server
>> ---
>>
>> When BlueZ is built with --enable-pnat option, it provides DUN support on RFComm
>> port 1.
>> When current version of oFono is started, it also provides DUN support on same
>> port.
>> So, we get to 2 SDP records for same UUID and RFComm port.
>> This patch prevents this.
>>
>
> My initial reaction is that I don't think this is something that needs
> to be part of the SDP server. The admin of the system should be smart
> enough to not try to configure to identical&  conflicting services.
>
> Also, the RFCOMM server socket code in the kernel should already give an
> error if binding to the same channel is attempted twice, so this would
> look like a bug in one of the DUN implementations that they do not
> unregister their service record when binding the server socket fails. So
> simply fixing this bug would also make sure that two service records
> aren't present (though it would remove the existence of the clueless
> admin ;)
>
I took a look to oFono code, which used a copy of btio.c to create a 
listening socket.
But call to bt_io_listen() (which calls bind to rfcomm port 1) did not 
fail. So, oFono continue and register the sdp record.

I use upstream BlueZ and oFono, with kernel 3.2.0-25-generic.

> However, even if this was introduced it should be in its own function
> (e.g. sdpd_check_duplicate() called from within add_record_to_server)
> and not unnecessarily bloat the size of add_record_to_server.
>
I will send an updated version of the patch.

Regards

Fred


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

