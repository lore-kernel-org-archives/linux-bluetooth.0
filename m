Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukzLFmQ1VSDLDj_U0gORAUMLmVQMY_yy-UpzUWhwoNGk1tA@mail.gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
	<1324051799-21439-2-git-send-email-sancane@gmail.com>
	<CAKT1EBc=VRa9doQMDsOU+tBTZCrBjcsEkSD9Z_b37wO_CF15dg@mail.gmail.com>
	<CACLukzLoHB5u-Vp6RW1rE1z3HDo1hexw5eVOivQHmfhCwJqzAg@mail.gmail.com>
	<CAJdJm_O=m8L=TB2t8Z3Fc3awDFvAag=+-r4apbfRbTwNgSk7Dg@mail.gmail.com>
	<CACLukzLFmQ1VSDLDj_U0gORAUMLmVQMY_yy-UpzUWhwoNGk1tA@mail.gmail.com>
Date: Mon, 19 Dec 2011 15:54:42 +0100
Message-ID: <CACLukz+AqSqa5Xuq=pX66Gi5jM4opiMXi7M9-BoePv9h_FCB-w@mail.gmail.com>
Subject: Re: [PATCH 01/11] attrib-server: Initial steps to provide
 multi-adapter GATT server support
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/12/19 Santiago Carot <sancane@gmail.com>:
> Hi Anderson,
>
> 2011/12/19 Anderson Lizardo <anderson.lizardo@openbossa.org>:
>> Hi Santiago,
>>
>> On Mon, Dec 19, 2011 at 10:35 AM, Santiago Carot <sancane@gmail.com> wrote:
>>>> Is there race condition here? Remember that plugins can also register
>>>> an adapter driver.
>>>> If a GATT "plugin" wants to register attributes during the probing the
>>>> attribute server needs to be ready.
>>>>
>>>
>>> I know that, remember these are transactional patches towardas
>>> multi-adapter support. They only prepare the environment to start
>>> coding. The patch 11 fixes this issue. In fact, one could think that
>>> it should in this place but when I started coding it I thought it was
>>> easier to reutilize functions which were already implemented and
>>> change it after multi-adapter started working.
>>

Sorry: patch 10 is supposed to deal with that :P

>> I don't think patch 11 fixes the architectural issue of initializing
>> the attribute databases on a adapter driver. You can't guarantee it
>> will be initialized prior to other adapter drivers (registered by GATT
>> plugins).
>>
>
> Patch 11 removes the adapter driver usage and initializes the GATT
> server (and related stuff) in the adapter during the adapter setup,
> this is operation is done before any other adapter plugin is called:
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 1a701a4..200e9d9 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2483,6 +2483,10 @@ gboolean adapter_init(struct btd_adapter *adapter)
>       }
>
>       sdp_init_services_list(&adapter->bdaddr);
> +
> +       if (main_opts.attrib_server)
> +               btd_adapter_gatt_server_start(adapter);
> +
>       load_drivers(adapter);
>       clear_blocked(adapter);
>       load_devices(adapter);
>
> Please, corect me if I'm wrong.
>
>> Please take our comments as responses to the RFC :)
>
>  Of course, and they are very welcome ;)
> Regards.
