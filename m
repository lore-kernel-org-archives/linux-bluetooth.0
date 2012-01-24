Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 24 Jan 2012 13:29:50 +0100
Message-ID: <CA+i+Aw1zNAAqucMjN4hZxFqZ6KyY-S-zcOAs5i1DbaMps=OgTQ@mail.gmail.com>
Subject: bluez static analysis: plugins/hciops.c:init_adapter()
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In file plugins/hciops.c in function init_adapter(), at line 658,
there is following fragment:

	if (!dev->registered) {
		adapter = btd_manager_register_adapter(index);
		if (adapter)
			dev->registered = TRUE;
	} else {
		adapter = manager_find_adapter(&dev->bdaddr);
		/* FIXME: manager_find_adapter should return a new ref */
		btd_adapter_ref(adapter);
	}

	if (adapter == NULL)
		return FALSE;

btd_adapter_ref() directly dereferences adapter. In all other calls of
manager_find_adapter() in BlueZ code, returned value is checked for
NULL before any use.

Is it guaranteed here that manager_find_adapter() won't return NULL?

-- 
Slawomir Bochenski
