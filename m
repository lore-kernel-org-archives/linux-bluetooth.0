Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 24 Jan 2012 12:47:52 +0100
Message-ID: <CA+i+Aw3_NU7NRwG8PSZfgdt4pz-rSwsY0avO_Vsw-D_a1-sqZw@mail.gmail.com>
Subject: bluez static analysis: src/sdpd-database.c:sdp_record_remove()
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In file src/sdpd-database.c, at line 248 in function
sdp_record_remove(), possible flow:

int sdp_record_remove(uint32_t handle)
{
	sdp_list_t *p = record_locate(handle);
	sdp_record_t *r;
	sdp_access_t *a;

	if (!p) {
		error("Remove : Couldn't find record for : 0x%x", handle);
		return -1;
	}

	r = p->data;
### "r" taking false path (r is NULL)
	if (r)
		service_db = sdp_list_remove(service_db, r);

	p = access_locate(handle);
### "p == NULL" taking false path, "p->data == NULL" (p->data is no
longer the same as r because of previous line) taking false path
	if (p == NULL || p->data == NULL)
		return 0;

	a = p->data;

### in both paths here, "r" being NULL is going to be passed to
adapter_service_remove() which dereferences it directly
	if (bacmp(&a->device, BDADDR_ANY) != 0) {
		struct btd_adapter *adapter = manager_find_adapter(&a->device);
		if (adapter)
			adapter_service_remove(adapter, r);
	} else
		manager_foreach_adapter(adapter_service_remove, r);

	access_db = sdp_list_remove(access_db, a);
	access_free(a);

	return 0;
}

Is this possible in practice and could it cause a crash?

-- 
Slawomir Bochenski
