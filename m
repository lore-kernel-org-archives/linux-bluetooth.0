Return-Path: <cyrus@holtmann.org>
Message-ID: <4ECA7E29.6080909@bmw-carit.de>
Date: Mon, 21 Nov 2011 17:36:57 +0100
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Proposal for major API changes in obex-client
Content-Type: multipart/mixed;
	boundary="------------060609040105030009060309"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--------------060609040105030009060309
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I would like to propose some changes in obex-client's D-Bus API, 
refactoring parts of the existing API and rewriting others.

The main goals would be the following:

     - Higher level representation of devices and sessions, following 
the BlueZ style.
     - OPP operations wrapped into a specific session type, just like 
the rest.
     - Transfer objects are created always, making the API more orthogonal.
     - Content of the pulled files is written to a file, avoiding dbus 
overhead.
     - Removal of agent, since all requests are locally initiated.
     - Transfer progress reported using unicast signals to transfer 
initiator.

Given that the diff would be quite unreadable, I attach the modified 
'client-api.txt' document.

Please consider this as a first draft, open for discussion. I hope at 
least some of these points are valid.

Cheers,
Mikel


--------------060609040105030009060309
Content-Type: text/plain; name="client-api.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="client-api.txt"

OBEX client API description
***************************

Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.


Client hierarchy
================

Service		org.openobex.client
Interface	org.openobex.Client
Object path	/

Methods		array{object,dict} GetDevices()

			Get an array of remote devices and their properties,
			representing the devices known to support the Generic
			Object Exchange profile.

Signals		DeviceAdded(object path, dict properties)

			Signal that is sent when a new device is added. The
			the object path is provided and also its properties.

		DeviceRemoved(object path)

			Signal that is sent when a device has been removed.
			The object path is no longer accessible after this
			signal and only emitted for reference.

Device hierarchy
================

Service		org.openobex.client
Interface	org.openobex.Device
Object path	[variable prefix]/{device0,device1,...}

Methods		dict GetProperties()

			Returns all properties for the device. See the
			properties section for available properties.

		object CreateSession(string target)

			Create a new OBEX session for this device and given
			target. The supported targets are:
				- "OPP"
				- "FTP"
				- "SYNC"
				- "PBAP"

		void RemoveSession(object session)

			Unregister session and abort pending transfers.

Signals		PropertyChanged(string name, variant value)

			This signal indicates a changed value of the given
			property.

Properties	string Capabilities [read-only]

			Remote device capabilities.

		string Address [read-only]

			The Bluetooth device address of the remote device.

		string AdapterAddress [read-only]

			The Bluetooth device address of the local adapter.

		string State [read-only]

			Possible values are:
				- "disconnected" - no session exists
				- "connected" - at least one session exists
				- "transferring" - a transfer in progress

Session hierarchy
=================

Service		org.openobex.client
Interface	org.openobex.Session
Object path	[variable prefix]/{device0,device1,...}/{session0,session1,...}

Methods		dict GetProperties()

			Returns all properties for the session.

Properties	byte Channel [read-only]

		string Target [read-only]

Session hierarchy
=================

Service		org.openobex.client
Interface	org.openobex.ObjectPush
Object path	[variable prefix]/{device0,device1,...}/{session0,session1,...}

Methods		object SendFiles(array{string} files, string destination)

			Send one or multiple local files to the specified
			device.

			The returned path represents the newly created transfer,
			which should be used to know when the content has been
			successfully transferred. This object will represent
			the whole list of files, in a single transfer.

		object PullBusinessCard(string file, string targetfile)

			Request the business card from a remote device and
			store it in the local file.

			If an empty target file is given, a name will be
			automatically generated for the temporary file.

			The returned path represents the newly created transfer,
			which should be used to know when the content has been
			successfully transferred.

		object ExchangeBusinessCards(string clientfile,
							string targetfile)

			Push the client's business card to the remote device
			and then retrieve the remote business card and store
			it in a local file.

			If an empty target file is given, a name will be
			automatically generated for the temporary file.

			The returned path represents the newly created transfer,
			which should be used to know when the content has been
			successfully transferred.

File Transfer hierarchy
=======================

Service		org.openobex.client
Interface	org.openobex.FileTransfer
Object path	[variable prefix]/{device0,device1,...}/{session0,session1,...}

Methods		void ChangeFolder(string folder)

			Change the current folder of the remote device.

		void CreateFolder(string folder)

			Create a new folder in the remote device.

		array{dict} ListFolder()

			Returns a dictionary containing information about
			the current folder content.

			The following keys are defined:

				string Name : Object name in UTF-8 format
				string Type : Either "folder" or "file"
				uint64 Size : Object size or number of items in
						folder
				string Permission : Group, owner and other
							permission
				uint64 Modified : Last change
				uint64 Accessed : Last access
				uint64 Created : Creation date

		object GetFile(string targetfile, string sourcefile)

			Copy the source file (from remote device) to the
			target file (on local filesystem).

			If an empty target file is given, a name will be
			automatically generated for the temporary file.

			The returned path represents the newly created transfer,
			which should be used to know when the content has been
			successfully transferred.

		object PutFile(string sourcefile, string targetfile)

			Copy the source file (from local filesystem) to the
			target file (on remote device).

			The returned path represents the newly created transfer,
			which should be used to know when the content has been
			successfully transferred.

		void CopyFile(string sourcefile, string targetfile)

			Copy a file within the remote device from source file
			to target file.

		void MoveFile(string sourcefile, string targetfile)

			Move a file within the remote device from source file
			to the target file.

		void Delete(string file)

			Deletes the specified file/folder.

Phonebook Access hierarchy
=======================

Service		org.openobex.client
Interface	org.openobex.PhonebookAccess
Object path	[variable prefix]/{device0,device1,...}/{session0,session1,...}

Methods		void Select(string location, string phonebook)

			Select the phonebook object for other operations. Should
			be call before all the other operations.

			location : Where the phonebook is stored, possible
			inputs :
				"INT" ( "INTERNAL" which is default )
				"SIM" ( "SIM1" )
				"SIM2"
				...

			phonebook : Possible inputs :
				"pb" :	phonebook for the saved contacts
				"ich":	incoming call history
				"och":	outgoing call history
				"mch":	missing call history
				"cch":	combination of ich och mch

		object PullAll(string targetfile)

			Request the entire phonebook object from the PSE server
			in plain string with vcard format.

			If an empty target file is given, a name will be
			automatically generated for the temporary file.

			The returned path represents the newly created transfer,
			which should be used to know when the content has been
			successfully transferred.

		object List(string targetfile)

			Return an array of vcard-listing data which contains the
			vcard and the corresponding name. This information is
			written to the target file so that each entry
			represents one line, using the following format:
				1.vcf;John
				2.vcf;Foo
				3.vcf;Bar

			If an empty target file is given, a name will be
			automatically generated for the temporary file.

		object Pull(string vcard, string targetfile)

			Retrieve the vcard in the current phonebook object
			for example : Pull("0.vcf")

			If an empty target file is given, a name will be
			automatically generated for the temporary file.

			The returned path represents the newly created transfer,
			which should be used to know when the content has been
			successfully transferred.

		object Search(string field, string value, string targetfile)

			Return an array of vcard-listing data which contains the
			vcard and the corresponding name, for entries that match
			the search condition.

			The supported fields are:
				- "name" (default)
				- "number"
				- "sound"

			If an empty target file is given, a name will be
			automatically generated for the temporary file.

			See method List for more information on the return
			value.

		int GetSize()

			Return the number of the non-null entries in the
			selected phonebook object.

		void SetFormat(string format)

			Indicate the format of the vcard that should be return
			by related methods.

			format : { "vcard21" (default) | "vcard30" }

		void SetOrder(string order)

			Indicate the sorting method of the vcard-listing data
			returned by List and Search methods.

			order : { "indexed" (default) | "alphanumeric" |
					"phonetic" }

		void SetFilter(array{string})

			Indicate fields that should be contained in vcards
			return by related methods.

			Give an empty array will clear the filter and return
			all fields available in vcards. And this is the default
			behavior.

			Possible filter fields : "VERSION", "FN", ..., "ALL",
			"bit[0-63]"

		array{string} ListFilterFields()

			Return all Available fields that can be used in
			SefFilter method.

		array{string} GetFilter()

			Return the current filter setting

Synchronization hierarchy
=======================

Service		org.openobex.client
Interface	org.openobex.Synchronization
Object path	[variable prefix]/{device0,device1,...}/{session0,session1,...}

Methods		void SetLocation(string location)

			Set the phonebook object store location for other
			operations. Should be called before all the other
			operations.

			location: Where the phonebook is stored, possible
			values:
				"INT" ( "INTERNAL" which is default )
				"SIM1"
				"SIM2"
				......

		object GetPhonebook(string targetfile)

			Retrieve an entire Phonebook Object store from remote
			device.

			If an empty target file is given, a name will be
			automatically generated for the temporary file.

			The returned path represents the newly created transfer,
			which should be used to know when the content has been
			successfully transferred.

		object PutPhonebook(string obj)

			Send an entire Phonebook Object store to remote device.

			The returned path represents the newly created transfer,
			which should be used to know when the content has been
			successfully transferred.

Transfer hierarchy
==================

Service		org.openobex.client
Interface	org.openobex.Transfer
Object path	[variable prefix]/{device0,device1,...}/{session0,session1,...}

Methods		dict GetProperties()

			Returns all properties for the transfer. See the
			properties section for available properties.

		void Cancel()

			Cancels this transfer.

Properties	string Name [read-only]

			Name of the transferred object.

		uint64 Size [read-only, optional]

			Size of the transferred object(s). If the size is
			unknown, then this property will not be present.

		string Filename [read-only]

			Complete name of the file being received or sent. For
			operations involving several files, this property could
			change, in order to inform about the file currently
			being transferred.

Signals		PropertyChanged(string name, variant value)

			This signal indicates a changed value of the given
			property.

			This is emitted using a unicast signal to the
			application that created the transfer.

		void Progress(uint64 transferred)

			Progress within the transfer has been made. The
			number of transferred bytes is given as second
			argument for convenience.

			This is emitted using a unicast signal to the
			application that created the transfer.

		void Complete()

			Informs that the transfer has completed successfully.

			This is emitted using a unicast signal to the
			application that created the transfer.
 
		void Error(string message)

			Informs that the transfer has been terminated because
			of some error.

			This is emitted using a unicast signal to the
			application that created the transfer.

--------------060609040105030009060309--
