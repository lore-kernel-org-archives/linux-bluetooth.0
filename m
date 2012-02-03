Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 13:25:50 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: bluez static analysis: plugins/hciops.c:init_adapter()
Message-ID: <20120203212550.GA31898@x220.globalsuite.net>
References: <CA+i+Aw1zNAAqucMjN4hZxFqZ6KyY-S-zcOAs5i1DbaMps=OgTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+i+Aw1zNAAqucMjN4hZxFqZ6KyY-S-zcOAs5i1DbaMps=OgTQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Jan 24, 2012, Slawomir Bochenski wrote:
> In file plugins/hciops.c in function init_adapter(), at line 658,
> there is following fragment:
> 
> 	if (!dev->registered) {
> 		adapter = btd_manager_register_adapter(index);
> 		if (adapter)
> 			dev->registered = TRUE;
> 	} else {
> 		adapter = manager_find_adapter(&dev->bdaddr);
> 		/* FIXME: manager_find_adapter should return a new ref */
> 		btd_adapter_ref(adapter);
> 	}
> 
> 	if (adapter == NULL)
> 		return FALSE;
> 
> btd_adapter_ref() directly dereferences adapter. In all other calls of
> manager_find_adapter() in BlueZ code, returned value is checked for
> NULL before any use.
> 
> Is it guaranteed here that manager_find_adapter() won't return NULL?

In general a function called "find" can obviously return NULL even
though in this case it should be in practice impossible. For consistency
the check should be there though. Please send a patch.

Johan
