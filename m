Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] API v2 for MAP client in obex-client
Date: Tue,  8 Nov 2011 15:37:13 +0100
Message-Id: <1320763033-4072-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
below tweaked proposal for MAP client API.

Messages Access hierarchy
=========================

Service		org.openobex.client
Interface	org.openobex.MessagesAccess
Object path	[variable prefix]/{session0,session1,...}

Methods		dict(uint8 tag, variant value) GetAppParams()

			Retrieve application parameters connected to the last MSE 
			response. Application parameters corresponding to given call
			are accessible until next request is sent.

			Parameters are converted to unsigned integers of corresponding sizes
			(MAP specification section 6.3.1) or NULL-terminated strings.
			In case of parameters not mentioned in MAP specification value 
			becomes struct of (uint8 length, array{uint8}).

			See MAP specification (section corresponding to given function)
			for more details on returned parameters.

		void SetFolder(boolean cdup, string name)

			Set working directory for current session.

			|  cdup  | folder name | operation    | 
			|=====================================|
			| FALSE  | empty       | cd /         |
			|--------+-------------+--------------|
			| FALSE  | name        | cd name      |
			|--------+-------------+--------------|
			| TRUE   | [name]      | cd ..[/name] |
			+-------------------------------------+

		array{dict(string property, string value)}
		GetFolderListing(dict(uint8 tag, uint16 value))

			Retrieve list of names (and all other properties returned by MSE)
			for directories in CWD.

			Parameters as in MAP specification section 5.4.

		array{dict(string property, string value)}
		GetMessageListing(string folder, array{uint8 tag, variant value})

			Return message listing for given subfolder of CWD or directly
			CWD if folder field is empty, format of each dict entry
			corresponds to the message listing format (MAP specification
			section 3.1.6).

			Parameters as in MAP specification section 5.5.

		object_path
		GetMessage(string handle, dict(uint8 tag, variant value), string filename)

			Retrieve message (in BMSG format) from remote device and save
			it to a file *filename* (filename should be an absolute path
			and the file would be overwritten if it already exists).

			A new Transfer object is created to represent this transaction
			and object_path pointing to it is returned.

			Parameters as in MAP specification section 5.6.

		void SetMessageStatus(string handle, uint8 indicator, uint8 value)

			Modify status of a message on remote device.

			Parameters as in MAP specification section 5.7.

		void UpdateInbox()

			Initiate update of inbox status on remote device.

-- 
Pozdrowienia - Cheers,
Bartosz Szatkowski
