Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100921110529.GA10156@jh-x301>
References: <1285056861-10099-1-git-send-email-santoscadenas@gmail.com> <20100921110529.GA10156@jh-x301>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Tue, 21 Sep 2010 13:07:49 +0200
Message-ID: <AANLkTi=L_iB7Evf9OdRxhVH+-dwdH8sdJ79Mu5tab8Oj@mail.gmail.com>
Subject: Re: [PATCH] Some code reordering in mcap_sync
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2010/9/21 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi,
>
> On Tue, Sep 21, 2010, Jose Antonio Santos Cadenas wrote:
>> Declaration, defines and struct definitions are moved to the begining
>> of the file. Just for make the code more readable.
>> ---
>>  health/mcap_sync.c |   86 +++++++++++++++++++++++++--------------------------
>>  1 files changed, 42 insertions(+), 44 deletions(-)
>
> Thanks, the patch is now upstream. While you're at it, please also
> remove any unnecessary forward declarations, like these:

Ok, I'll work on it.

>
>> +static void proc_sync_cap_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
>> +static void proc_sync_set_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
>> +static void proc_sync_cap_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
>> +static void proc_sync_set_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
>> +static void proc_sync_info_ind(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
>
> Only in very rare cases are forward declarations needed. Whenever
> possible order the functions so that the dependencies of a function are
> defined above the function in the C file.
>
>> +static gboolean sync_send_indication(gpointer user_data);
>> +static gboolean proc_sync_set_req_phase2(gpointer user_data);
>
> Same here.
>
> Johan
>
